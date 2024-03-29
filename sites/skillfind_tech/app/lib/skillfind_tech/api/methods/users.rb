# frozen_string_literal: true

module SkillfindTech
  module Api
    module Methods
      class Users < Grape::API
        params do
          requires :email_address, type: String
          requires :password, type: String
          requires :consents, type: Array do
            requires :type, type: String
            requires :granted, type: Boolean
            requires :displayed_text, type: String
          end
        end
        post do
          user ||= site::User.find_or_initialize_by(email: params[:email_address])
          user.change_log = []

          # TODO: Consents!
          # ::Parsers::User::Consents.new(user: user, consents: params[:consents]).call
          ::Ciphers::User::HashPassword.new(user: user, password: params[:password]).call

          user.save!

          ::Commands::User::Update::Attribute.new(
            user_id: user.id,
            name: 'email_verified_at',
            value: Time.zone.now,
            constantized_site_name: constantized_site_name,
          ).call
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
