# frozen_string_literal: true

module Warsawlease
  module Api
    module Tracks
      module Root
        class Linker
          include ::Warsawlease::Api::Tracks::Helpers::Linker
          include ::Warsawlease::Api::Tracks::Root::Meta

          def initialize(lang, url = nil)
            @lang = lang
            @url = url
          end

          attr_reader :url

          def call
            {
              pl: { path: '/' },
              en: { path: '/en' }
            }[lang]
          end

          def venue_links
            {
              'root/map': { path: venue_path(:map, lang).chomp('/') },
              'root/catalogue': { path: venue_path(:catalogue, lang) }
            }
          end

          def category_links(venue)
            category_links_hash = {}

            ::Warsawlease::Announcement::CATEGORIES.each_value do |category|
              category_links_hash["root/#{venue}/#{category[:name][:en].downcase}"] = {
                path: category_link(category, lang)
              }
            end

            category_links_hash
          end

          def lang_links(venue)
            if category.present?
              return {
                pl: { path: "#{category_venue_path(venue, :pl)}/#{::Warsawlease::Announcement::CATEGORIES[category][:plural_urlified][:pl]}" },
                en: { path: "#{category_venue_path(venue, :en)}/#{::Warsawlease::Announcement::CATEGORIES[category][:plural_urlified][:en]}" }
              }
            end

            {
              pl: { path: venue_path(venue, :pl).chomp('/') },
              en: { path: venue_path(venue, :en) }
            }
          end

          private

          def venue_path(venue, lang)
            case venue
            when :map
              lang == :pl ? '' : 'en'
            when :catalogue
              lang == :pl ? 'warszawa/wynajem/nieruchomosci/katalog' : 'property/catalogue'
            end
          end

          def category_link(category, lang)
            "#{category_venue_path(venue, lang)}/#{category[:plural_urlified][lang]}"
          end

          def category_venue_path(venue, lang)
            case lang
            when :pl
              venue == :map ? 'warszawa/wynajem/nieruchomosci/mapa' : 'warszawa/wynajem/nieruchomosci/katalog'
            when :en
              venue == :catalogue ? 'property/map' : 'property/catalogue'
            end
          end
        end
      end
    end
  end
end
