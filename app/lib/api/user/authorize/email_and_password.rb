# frozen_string_literal: true

module Api
  module User
    module Authorize
      class EmailAndPassword < Grape::API
        desc 'Signs in a User with Email & Password.'
        params do
          requires :email, type: String, desc: 'User\'s email.'
          requires :password, type: String, desc: 'User\'s password'
        end
        put do
          user = ::Commands::User::Authorize::EmailAndPassword.new(params.merge(constantized_site_name: constantized_site_name)).call

          private_key = RbNaCl::Signatures::Ed25519::SigningKey.new(ENV['JWT_SECRET'])
          payload = { id: user.id }
          JWT.encode payload, private_key, 'ED25519'
        rescue ActiveRecord::RecordNotFound, ::Commands::User::Authorize::EmailAndPassword::PasswordError
          error!('Invalid email or password.', 400)
        end
      end
    end
  end
end
