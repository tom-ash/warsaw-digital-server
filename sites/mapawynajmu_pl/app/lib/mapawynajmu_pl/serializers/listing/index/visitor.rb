# frozen_string_literal: true

module MapawynajmuPl
  module Serializers
    module Listing
      module Index
        class Visitor
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
            locality
            sublocality
            name
            link
            is_promoted
          ].freeze

          def initialize(announcements:, lang:, path:)
            @announcements = announcements
            @lang = lang
            @path = path
          end

          def call
            announcements.map { |announcement| serialize_announcement(announcement) }
          end

          private

          attr_reader :announcements, :lang, :path

          def serialize_announcement(announcement)
            serialized_announcement = announcement.attributes.slice(*ATTRS)
            serialized_announcement['href'] = "#{href_prefix}#{announcement.url(lang)}"
            serialized_announcement['title'] = announcement.title(lang)
            serialized_announcement
          end

          def href_prefix
            @href_prefix ||= begin
              href_elements = ['/']
              href_elements.push("#{path}/") if path.present?
              href_elements.join()
            end
          end
        end
      end
    end
  end
end
