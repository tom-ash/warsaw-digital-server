# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Listing
        module Show
          module Meta
            include ::MapawynajmuPl::Api::Tracks::Listing::Common::PartnerAndCategory

            TRACK = 'announcement/show'

            PARTNER_PL = "partnerzy\/(?<current_partner_name>[^\/]+)"
            PARTNER_EN = "partners\/(?<current_partner_name>[^\/]+)"

            CATEGORY_PL = "wynajem/(?<current_category_name>#{::MapawynajmuPl::Listing::URL_CATEGORIES})"
            CATEGORY_EN = "rent/(?<current_category_name>#{::MapawynajmuPl::Listing::URL_CATEGORIES})"

            LISTING_PL = '\d+-.*-na-wynajem.*'
            LISTING_EN = '\d+-.*-for-(rent|lease).*'

            UNLOCALIZED_PATH = {
              pl: %r{^(#{PARTNER_PL}\/)?(#{CATEGORY_PL}\/)?#{LISTING_PL}$},
              en: %r{^(#{PARTNER_EN}\/)?(#{CATEGORY_EN}\/)?#{LISTING_EN}$},
            }.freeze

            private

            def render
              {
                visitor: true,
                announcement: true,
                'listings/show': true
              }
            end

            def links
              {}.merge(
                ::MapawynajmuPl::Api::Tracks::Listing::Show::Linker.new(announcement: announcement, lang: lang, url: url).category_links,
                ::MapawynajmuPl::Api::Tracks::Listing::Show::Linker.new(announcement: announcement, lang: lang, url: url).linkMap,
                ::MapawynajmuPl::Api::Tracks::Listing::Show::Linker.new(announcement: announcement, lang: lang, url: url).go_back_link,
              )
            end

            def title
              @title ||= announcement.title(lang)
            end

            def description
              @description ||= announcement.description(lang)
            end

            def keywords
              @keywords ||= announcement.keywords(lang)
            end

            def image
              @image ||= announcement.image
            end

            def category
              nil
            end

            def unlocalized_path
              @unlocalized_path ||= UNLOCALIZED_PATH
            end

            def root_path
              @root_path ||=               {
                pl: ::MapawynajmuPl::Api::Tracks::Root::Meta::ROOT_PL,
                en: ::MapawynajmuPl::Api::Tracks::Root::Meta::ROOT_EN,
              }[lang]
            end
          end
        end
      end
    end
  end
end
