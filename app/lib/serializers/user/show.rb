# frozen_string_literal: true

module Serializers
  module User
    class Show
      include SiteName

      def initialize(user:, constantized_site_name:)
        @user = user
        @constantized_site_name = constantized_site_name
      end

      def call
        {
          accountType: user.account_type,
          role: user.role,
          authorized: true,
        }
      end

      private

      attr_reader :user, :constantized_site_name
    end
  end
end
