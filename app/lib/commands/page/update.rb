# frozen_string_literal: true

module Commands
  module Page
    class Update
      include SiteName

      PAGE_UPDATE_ATTRS = %w[
        url
        lang
        body
        canonical_url
        title
        description
        keywords
        cover_image
        online
        header_autonumbering
        schema_mode
        auto_schema
        manual_schema
        published_on
        modified_on
        lang_alts_group
        parent_id
        priority
      ].freeze

      def initialize(attrs)
        @attrs = attrs
        @constantized_site_name = attrs[:constantized_site_name]
        @bucket = attrs[:bucket]
      end

      def call
        update_page
        backup_page
        page
      end

      private

      attr_reader :attrs, :constantized_site_name, :bucket

      def update_page
        page.update!(attrs.slice(*PAGE_UPDATE_ATTRS))
      end

      def backup_page
        ::Commands::S3Object::Upload.new(
          bucket: bucket,
          key: backup_key,
          body: page.to_json,
        ).call
      end

      def page
        @page ||= site::Page.find(attrs[:id])
      end

      def backup_key
        "pages/#{page.url} (#{page.updated_at})"
      end
    end
  end
end
