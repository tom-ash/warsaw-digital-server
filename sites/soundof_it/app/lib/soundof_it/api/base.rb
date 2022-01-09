# frozen_string_literal: true

module SoundofIt
  module Api
    class Base < ::Api::Base
      SITENAME = 'SoundofIt'
      SITE_TITLE = 'soundof.IT'
      LANGS = %i[en].freeze

      helpers do
        def site_name
          @site_name ||= SITENAME
        end

        def site_title
          @site_title ||= SITE_TITLE
        end

        def page_langs
          @page_langs ||= LANGS
        end

        def langs
          @langs ||= LANGS
        end

        def sitemaps
          [
            ::SoundofIt::Api::Tracks::Root::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::Contact::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::TermsOfService::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::CookiesPolicy::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::PrivacyPolicy::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::PrivacySettings::Sitemap
          ]
        end
      end

      mount ::Api::Sitemap => 'sitemap'
      mount ::SoundofIt::Api::Sync => 'sync'
    end
  end
end