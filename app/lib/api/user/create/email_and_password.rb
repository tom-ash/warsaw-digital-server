# frozen_string_literal: true

module Api
  module User
    module Create
      class EmailAndPassword < Grape::API

        class VerificationCodeMismatch < StandardError; end

        helpers ::MapawynajmuPl::ProtocolAndDomain

        params do
          optional :business_name, type: String
          requires :email_address, type: String
          requires :password, type: String
          requires :country_code, type: String
          requires :phone_number, type: String
          requires :consents, type: Array do
            requires :type, type: String
            requires :granted, type: Boolean
            requires :displayed_text, type: String
          end
        end
        post do
          user = ::Commands::User::Create::EmailAndPassword.new(
            params.merge(
              email: email,
              constantized_site_name: constantized_site_name,
            ),
          ).call

          verificationCode = rand(1000..9999).to_s

          ::Mailers::Verification.new(
            email: email,
            namespace: 'user/create/email-and-password',
            lang: lang,
            verification_code: verificationCode,
          ).send

          verificationToken = {
            verificationCode: verificationCode,
            userId: user.id,
          }
          encodedVerificationToken = ::Ciphers::Jwt::Encoder.new(verificationToken).call

          {
            verificationToken: encodedVerificationToken,
            userId: user.id,
            path: site::Api::Tracks::User::Create::Verification::Meta::UNLOCALIZED_PATH[lang.to_sym],
          }
        end

        params do
          requires :verification_token, type: String
          requires :verification_code, type: String
        end
        put do
          decodedVerificationToken = ::Ciphers::Jwt::Decoder.new(params['verification_token']).call
          raise VerificationCodeMismatch if decodedVerificationToken['verificationCode'] != params['verification_code']

          user_id = decodedVerificationToken['userId']
          user = ::MapawynajmuPl::User.find(user_id)
          raise VerificationCodeMismatch if user.verified?

          ActiveRecord::Base.transaction do
            ::Commands::User::Update::Attribute.new(
              user_id: user.id,
              name: 'email_verified_at',
              value: Time.zone.now,
              constantized_site_name: constantized_site_name,
            ).call

            site::Commands::User::Confirm.new(user_id: user.id).call
          end

          encodedAccessToken = ::Ciphers::Jwt::Encoder.new(id: user.id).call

          current_announcement = user.listings.last

          listing_confirmation_href = begin
            listing_confirmation_path = current_announcement&.summary_path(lang.to_sym)
            "#{protocol_and_domain}/#{listing_confirmation_path}" if listing_confirmation_path.present?
          end

          user_confirmation_href = ::MapawynajmuPl::Api::Tracks::User::Create::Confirmation::Linker.new(
            lang.to_sym,
            user_id: user.id,
          ).call[:href]

          href = listing_confirmation_href || user_confirmation_href

          if current_announcement
            TransactionalMailer.listing_confirmation_email(
              to: user.email,
              listing_id: current_announcement.id,
              lang: lang,
            ).deliver_now
          end

          if (current_announcement&.is_promoted?)
            href = MapawynajmuPl::Commands::Order::Create.new(
              listing_id: current_announcement.id,
              name: 'listing_promotion',
              price: 1900,
              currency: 'PLN',
              lang: lang,
              customer_ip: request.ip,
            ).call
          end

          {
            accessToken: encodedAccessToken,
            href: href,
          }
        rescue VerificationCodeMismatch
          error!('Invalid confirmation token or verification code!', 422)
        end
      end
    end
  end
end
