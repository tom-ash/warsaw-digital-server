# frozen_string_literal: true

module Commands
  module Page
    class Create
      include SiteName

      class PageWithNameExistsError < StandardError; end

      def initialize(name:, page_langs:, user_id:, site_name:)
        @name = name
        @page_langs = page_langs
        @user_id = user_id
        @site_name = site_name
      end

      def call
        raise PageWithNameExistsError if site::Page.where(name: name).any?

        create_pages
      end

      private

      attr_reader :name, :page_langs, :user_id, :site_name

      def create_pages
        page_langs.each do |lang|
          user.pages.create!(
            name: name, lang: lang, url: SecureRandom.hex(32),
            body: [], style: [], meta: {},
            canonical_url: '', title: '', keywords: '', description: '', picture: ''
          )
        end
      end

      def user
        @user ||= site::User.find(user_id)
      end
    end
  end
end