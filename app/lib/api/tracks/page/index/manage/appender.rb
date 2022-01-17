# frozen_string_literal: true

module Api
  module Tracks
    module Page
      module Index
        module Manage
          class Appender
            include ::Api::Tracks::Helpers::Appender
            include ::Api::Tracks::Page::Index::Manage::Meta

            private

            def merge_state
              state.merge!(
                'page/index/data': {
                  pages: serialized_pages
                },
                'page/index/inputs': {
                  name: ''
                }
              )
            end

            def serialized_pages
              ::Serializers::Page::Index.new(pages: pages, constantized_site_name: constantized_site_name).call
            end

            def pages
              site::Page.all.select(:name, :lang, :url)
            end
          end
        end
      end
    end
  end
end
