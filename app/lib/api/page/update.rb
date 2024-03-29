# frozen_string_literal: true

module Api
  module Page
    class Update < Grape::API
      before { authorize_for_page! }

      params do
        requires :id, type: String
        requires :page_lang, type: String
        requires :url, type: String
        requires :body, type: String
        requires :canonical_url, type: String
        requires :title, type: String
        requires :description, type: String
        requires :keywords, type: String
        requires :cover_image, type: String
        requires :schema_mode, type: String
        requires :auto_schema, type: String
        requires :manual_schema, type: String
        requires :published_on, type: Date
        requires :modified_on, type: Date
        optional :priority, type: Integer
      end
      put do
        body = JSON.parse(params[:body])
        auto_schema = JSON.parse(params[:auto_schema])
        manual_schema = JSON.parse(params[:manual_schema])

        attrs = params.merge(
          lang: params[:page_lang],
          user_id: authenticated_user.id,
          constantized_site_name: constantized_site_name,
          bucket: bucket,
          body: body,
          auto_schema: auto_schema,
          manual_schema: manual_schema,
        )

        page = ::Commands::Page::Update.new(attrs).call

        ::Builders::Pages::SchemaOrgBuilder.new(
          page: page,
          domain_url: domain_url,
          bucket: bucket,
        ).call

        {
          href: "#{domain_url}/#{page.url}",
        }
      end
    end
  end
end
