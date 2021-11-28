# frozen_string_literal: true

module Api
  module Tracks
    module Page
      module Show
        class Appender
          include ::Api::Tracks::Helpers::Appender
          include ::Api::Tracks::Page::Show::Meta

          class PageNotFoundError < StandardError; end
          # TODO: PageNotFoundError: return error!('Page Not Found!.', 404) if page.blank?

          private

          def page
            @page ||= site::Page.find_by!(url: url)
          end

          def merge_state
            state.merge!(
              'app': { lang: page.lang },
              'page/show/data': ::Serializers::Page::Show.new(page: page, site_name: site_name).call,
              links: {
                'page/edit': page.edit_link,
                'langs': page.lang_show_links
              }
            )
          end

          def merge_meta
            meta.merge!(
              lang: page.lang,
              title: page.title,
              description: page.description,
              keywords: page.keywords,
              image: page.picture
            )
          end
        end
      end
    end
  end
end