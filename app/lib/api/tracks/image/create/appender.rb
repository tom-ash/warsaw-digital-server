# frozen_string_literal: true

module Api
  module Tracks
    module Image
      module Create
        class Appender
          include ::Api::Tracks::Helpers::Appender
          include ::Api::Tracks::Image::Create::Meta

          private

          def merge_state



            # state.merge!(
            #   'image/edit/data': {
            #     id: image.id,
            #     body: JSON.pretty_generate(image.body),
            #     width: image.width,
            #     height: image.height,
            #     storage_key: image.storage_key,
            #     storage_url: image.storage_url
            #   }
            # )
          end

          # def image
          #   @image ||= site::Image.find_by(storage_key: storage_key)
          # end

          # def storage_key
          #   @storage_key ||= url.match(%r{(edit-image|edytuj-obraz)\/(.+)})[2]
          # end
        end
      end
    end
  end
end
