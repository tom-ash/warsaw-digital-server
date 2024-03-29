# frozen_string_literal: true

module MapawynajmuPl
  module Commands
    module User
      class Confirm
        def initialize(user_id:)
          @user_id = user_id
        end

        def call
          user.listings.last&.update!(user_verified: true)
        end

        private

        attr_reader :user_id

        def user
          @user ||= ::MapawynajmuPl::User.find(user_id)
        end
      end
    end
  end
end
