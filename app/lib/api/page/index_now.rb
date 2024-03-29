# frozen_string_literal: true

module Api
  module Page
    class IndexNow < Grape::API
      before { authorize_for_page! }

      params do
        requires :id, type: String
      end
      put do
        return unless Rails.env == 'production'

        page = site::Page.find(params[:id])

        uri = URI("https://www.bing.com/indexnow?url=#{domain_url}/#{page.url}&key=#{index_now_key}")

        Net::HTTP.get_response(uri)

        page.update(index_now_pinged_at: Time.now)
      end
    end
  end
end
