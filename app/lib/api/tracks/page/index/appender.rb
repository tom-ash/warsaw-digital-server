# frozen_string_literal: true

module Api
  module Tracks
    module Page
      module Index
        class Appender
          include ::Api::Tracks::Helpers::Appender
          include ::Api::Tracks::Page::Index::Meta

          private

          def data
            {
              page_keys: page_keys,
              page_key: '',
            }
          end

          def page_keys
            @page_keys ||= site::Page.order(url: :asc).pluck(:url)
          end

          # export const control = {
          #   connecting: false,
          # }

          # export const inputs = {
          #   name: null,
          # }

          # export const data = {
          #   names: null,
          # }
        end
      end
    end
  end
end
