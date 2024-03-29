# frozen_string_literal: true

module Api
  module User
    module Authorize
      class EmailAndPassword < Grape::API
        class UserDeletedError < StandardError; end

        desc 'Signs in a User with Email & Password.'
        params do
          requires :email, type: String, desc: 'User\'s email.'
          requires :password, type: String, desc: 'User\'s password'
        end
        put do
          user = ::Commands::User::Authorize::EmailAndPassword.new(
            params.merge(constantized_site_name: constantized_site_name),
          ).call

          raise UserDeletedError if user.deleted_at?

          accessToken = ::Ciphers::Jwt::Encoder.new(id: user.id).call
          href = ::MapawynajmuPl::Api::Tracks::Root::Linker.new(lang.to_sym).call[:href]

          {
            accessToken: accessToken,
            href: href,
          }
        rescue UserDeletedError, ActiveRecord::RecordNotFound, ::Commands::User::Authorize::EmailAndPassword::PasswordError
          # TODO!: Change 400 to 422.
          error!('Invalid email or password.', 400)
        end
      end
    end
  end
end
