# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Visitor
        module PrivacySettings
          class Appender
            include ::Api::Tracks::Helpers::Appender
            include ::SkillfindTech::Api::Tracks::Visitor::PrivacySettings::Meta
          end
        end
      end
    end
  end
end