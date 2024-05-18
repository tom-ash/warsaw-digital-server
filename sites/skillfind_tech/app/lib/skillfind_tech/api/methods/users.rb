# frozen_string_literal: true

module SkillfindTech
  module Api
    module Methods
      class Users < Grape::API
        params do
          requires :business_name, type: String
          requires :industry, type: String
          requires :logo, type: String
          requires :email_address, type: String
          requires :password, type: String
          requires :consents, type: Array do
            requires :type, type: String
            requires :granted, type: Boolean
            requires :displayed_text, type: String
          end
          optional :link, type: String
        end
        post do
          user ||= site::User.find_or_initialize_by(email: params[:email_address])

          error!('users.email_already_registered', 422) if user.verified?
          
          user.business_name = params[:business_name]
          user.industry = params[:industry]
          user.link = params[:link]
          user.logo = "#{user.business_name.parameterize}.png"
          user.change_log = []

          # TODO: Consents!
          # ::Parsers::User::Consents.new(user: user, consents: params[:consents]).call
          ::Ciphers::User::HashPassword.new(user: user, password: params[:password]).call

          temporary_logo ||= Aws::S3::Object.new(
            credentials: CREDS,
            region: Rails.application.secrets.aws_region,
            bucket_name: bucket,
            key: "temporary/#{params[:logo]}",
          )

          user.save!

          temporary_logo.move_to("#{bucket}/logos/#{user.logo}")

          verificationCode = rand(1000..9999).to_s

          ::Mailers::Verification.new(
            email: params[:email_address],
            namespace: 'user/create/email-and-password',
            lang: lang,
            verification_code: verificationCode,
          ).send

          decodedVerificationToken = {
            verificationCode: verificationCode,
            userId: user.id,
          }
          verificationToken = ::Ciphers::Jwt::Encoder.new(decodedVerificationToken).call
          href = ::SkillfindTech::Api::Tracks::User::New::Verify::Linker.new(lang, id: user.id).call[:href]

          {
            href: href,
            verificationToken: verificationToken,
          }
        end

        params do
          requires :verification_token, type: String
          requires :verification_code, type: String
        end
        put do
          decodedVerificationToken = ::Ciphers::Jwt::Decoder.new(params['verification_token']).call
          raise StandardError if decodedVerificationToken['verificationCode'] != params['verification_code']

          user_id = decodedVerificationToken['userId']
          user = ::SkillfindTech::User.find(user_id)
          raise StandardError if user.verified?

          user.update!(email_verified_at: Time.zone.now)

          encodedAccessToken = ::Ciphers::Jwt::Encoder.new(id: user.id).call

          {
            accessToken: encodedAccessToken,
            href: '/',
          }
        rescue StandardError
          error!('Verification code invalid!', 422)
        end

        params do
          requires :email, type: String, desc: 'User\'s email.'
          requires :password, type: String, desc: 'User\'s password'
        end
        post 'auth' do
          user = ::Commands::User::Authorize::EmailAndPassword.new(params.merge(constantized_site_name: constantized_site_name)).call
          accessToken = ::Ciphers::Jwt::Encoder.new(id: user.id).call
          href = ::SkillfindTech::Api::Tracks::Root::Linker.new(lang).call[:href]

          {
            accessToken: accessToken,
            href: href,
          }
        rescue ActiveRecord::RecordNotFound, ::Commands::User::Authorize::EmailAndPassword::PasswordError
          error!('Invalid email or password.', 400)
        end
      end
    end
  end
end
