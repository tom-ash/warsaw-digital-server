# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Listing
        module Create
          module Summary
            class Appender < ::MapawynajmuPl::Api::Tracks::Common::Appender
              include ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Meta
              include ::MapawynajmuPl::Api::Tracks::Listing::Common::Promotion
              include ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Assets

              private

              def texts
                getLocalizations('sites/mapawynajmu_pl/app/lib/mapawynajmu_pl/api/tracks/listing/create/summary/texts.json')[lang].merge(promotion_texts)
              end

              def data
                {
                  announcement: ::MapawynajmuPl::Serializers::Listing::Show.new(announcement).call.merge(
                    href: "/#{announcement.url(lang)}",
                    title: announcement.title(lang),
                    image: announcement.image,
                  ),
                }
              end
            end
          end
        end
      end
    end
  end
end
