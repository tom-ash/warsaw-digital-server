# frozen_string_literal: true

module Api
  module Image
    class Create < Grape::API
      # TODO: before { authorize_for_page! }

      params do
        requires :image_key, type: String
      end
      post do
        image_key = params[:image_key]

        raise 'Empty Image Key Error' unless image_key.present? && authenticated_user.present?

        site::Image.create(
          added_by_id: authenticated_user.id,
          storage_key: image_key,
          body: [],
        )

        {
          # TODO!
          href: "images/#{image_key}",
        }
      end
    end
  end
end
