# frozen_string_literal: true

module Warsawlease
  module Api
    module Tracks
      module Root
        class Appender
          include ::Api::Tracks::Helpers::Appender
          include ::Warsawlease::Api::Tracks::Root::Meta
          include ::Warsawlease::Api::Announcement::Tracks::Helpers::Announcements
          include ::Warsawlease::Api::Announcement::Tracks::Helpers::Filters

          private

          def merge_state
            state.merge!(
              'announcement/index/data': data,
              'announcement/index/inputs': inputs
            )
          end

          def data
            {
              announcements: serialized_announcements,
              amount: serialized_announcements.count,
              current_category: category
            }
          end

          def page_name
            @page_name ||= 'welcome'
          end
        end
      end
    end
  end
end
