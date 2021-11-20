# frozen_string_literal: true

module Warsawlease
  module Api
    module Visitor
      module Tracks
        module PrivacySettings
          class Merge < ::Warsawlease::Api::Visitor::Tracks::Base
            include ::Warsawlease::Api::Visitor::Tracks::PrivacySettings::Meta

            def call
              merge_meta
            end

            private

            def merge_meta
              meta.merge!(
                title: title,
                keywords: keywords,
                description: description
              )
            end
          end
        end
      end
    end
  end
end