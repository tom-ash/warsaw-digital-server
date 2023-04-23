# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Listing
        module Create
          module Form
            class Sitemap
              class << self
                include ::SkillfindTech::Api::Tracks::Listing::Create::Form::Meta

                def get
                  [links]
                end

                private

                def links
                  [
                    { path: unlocalized_path[:en], lang: :en, changefreq: 'monthly', priority: '1.0' }
                  ]
                end
              end
            end
          end
        end
      end
    end
  end
end
