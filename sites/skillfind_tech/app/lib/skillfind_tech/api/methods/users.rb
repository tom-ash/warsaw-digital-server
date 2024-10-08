# frozen_string_literal: true

module SkillfindTech
  module Api
    module Methods
      class Users < Grape::API
        params do
          requires :business_name, type: String
          requires :industry, type: String
          requires :logo, type: String
          requires :email, type: String
          requires :password, type: String
          requires :consents, type: Array do
            requires :type, type: String
            requires :granted, type: Boolean
            requires :displayed_text, type: String
          end
          optional :link, type: String
        end
        post do
          user ||= site::User.find_or_initialize_by(email: params[:email])

          error!('users.email_already_registered', 422) if user.verified?
          
          user.business_name = params[:business_name]
          user.industry = params[:industry]
          user.link = params[:link] == 'https://' ? nil : params[:link] # TODO
          user.logo = params[:logo]
          user.change_log = []

          ::Parsers::User::Consents.new(user: user, consents: params[:consents]).call
          ::Ciphers::User::HashPassword.new(user: user, password: params[:password]).call

          user.save!

          verificationCode = rand(1000..9999).to_s

          ::SkillfindTech::Mailers::Poster::Verification::Account::Sender.prepare(
            to: params[:email],
            verification_code: verificationCode,
            lang: lang,
          ).deliver_now

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
          sleep(1)

          decodedVerificationToken = ::Ciphers::Jwt::Decoder.new(params['verification_token']).call
          raise StandardError if decodedVerificationToken['verificationCode'] != params['verification_code']

          user_id = decodedVerificationToken['userId']
          user = ::SkillfindTech::User.find(user_id)
          raise StandardError if user.verified?

          user.update!(email_verified_at: Time.zone.now)

          encodedAccessToken = ::Ciphers::Jwt::Encoder.new(id: user.id).call

          temporary_logo ||= Aws::S3::Object.new(
            credentials: CREDS,
            region: Rails.application.secrets.aws_region,
            bucket_name: bucket,
            key: "temporary/#{user.logo}",
          )

          user.logo = "#{user.business_name.parameterize}-#{SecureRandom.uuid}.png"
          temporary_logo.move_to("#{bucket}/logos/#{user.logo}")

          user.save!

          posting = ::SkillfindTech::Posting.find_by(
            user_id: user_id,
          )

          if posting
            posting.verified = true
            posting.save!
  
            ::SkillfindTech::Mailers::Postings::Confirmation::Sender.prepare(
              to: user.email,
              posting_id: posting.id,
              lang: lang.to_sym,
            ).deliver_now

            return {
              accessToken: encodedAccessToken,
              href: '/',
            }
          end

          {
            accessToken: encodedAccessToken,
            href: '/',
          }
        rescue StandardError
          error!('Verification code invalid!', 422)
        end

        delete do
          time_now = Time.now

          # TODO: Use transaction.
          authenticated_user.update!(deleted_at: time_now)
          postings = ::SkillfindTech::Posting.where(user_id: authenticated_user.id)
          postings.update_all(deleted_at: time_now)
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
