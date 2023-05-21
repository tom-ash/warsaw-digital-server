# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Listing
        module Edit
          class Linker < ::MapawynajmuPl::Api::Tracks::Common::Linker
            def initialize(announcement:, lang:)
              @announcement = announcement
              @lang = lang
            end

            def call
              {
                path: announcement.edit_path(lang),
                title: 'TODO',
              }
            end

            private

            attr_reader :announcement, :lang
          end
        end
      end
    end
  end
end