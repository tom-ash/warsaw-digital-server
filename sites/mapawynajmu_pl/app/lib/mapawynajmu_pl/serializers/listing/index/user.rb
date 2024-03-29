# frozen_string_literal: true

module MapawynajmuPl
  module Serializers
    module Listing
      module Index
        class User
          ATTRS = %w[
            id
            category
            area
            pictures
            longitude
            latitude
            rent_currency
            net_rent_amount
            net_rent_amount_per_sqm
            gross_rent_amount
            gross_rent_amount_per_sqm
            rooms
            floor
            total_floors
            availability_date
            status
            visible
            views
            active_until
            created_at
            updated_at
            locality
            sublocality
            name
            link
            is_promoted
          ].freeze

          def initialize(announcements, lang)
            @announcements = announcements
            @lang = lang
          end

          def call
            announcements.map { |announcement| serialize_announcement(announcement) }
          end

          private

          attr_reader :announcements, :lang

          def serialize_announcement(announcement)
            serialized_announcement = announcement.attributes.slice(*ATTRS)
            serialized_announcement['href'] = "/#{announcement.url(lang)}"
            serialized_announcement['title'] = announcement.title(lang)
            serialized_announcement['edit_href'] = "/#{announcement.edit_path(lang)}"
            serialized_announcement['edit_title'] = announcement.edit_title(lang)
            serialized_announcement
          end
        end
      end
    end
  end
end
