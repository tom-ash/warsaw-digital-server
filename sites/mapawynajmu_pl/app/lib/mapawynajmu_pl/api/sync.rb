# frozen_string_literal: true

module MapawynajmuPl
  module Api
    class Sync < ::Api::Sync
      helpers do
        def track_paths
          {
            ::MapawynajmuPl::Api::Tracks::Root::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Root::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Visitor::Contact::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::Contact::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Visitor::TermsOfService::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::TermsOfService::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Visitor::PrivacyPolicy::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::PrivacyPolicy::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Visitor::CookiesPolicy::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::CookiesPolicy::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Visitor::PrivacySettings::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::PrivacySettings::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::User::Create::Form::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Create::Form::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::User::Create::Verification::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Create::Verification::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::User::Create::Confirmation::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Create::Confirmation::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::User::Edit::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Edit::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::User::ResetPassword::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::ResetPassword::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::User::Authorize::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Authorize::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Listing::Create::Form::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Create::Form::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Listing::Show::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Show::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Listing::Edit::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Edit::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Listing::Promote::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Promote::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Page::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Page::Index::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Page::Edit::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Page::Edit::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Image::Edit::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Image::Edit::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Image::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Image::Index::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Assets::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Assets::Index::Meta::UNLOCALIZED_PATH,
            ::MapawynajmuPl::Api::Tracks::Redirects::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Redirects::Index::Meta::UNLOCALIZED_PATH,
          }
        end

        def append_track_data
          raise ::Api::TrackNotFoundError if track == 'page/not-found'

          case track
          when ::MapawynajmuPl::Api::Tracks::Root::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Root::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Visitor::Contact::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Visitor::Contact::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Visitor::TermsOfService::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Visitor::TermsOfService::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Visitor::PrivacyPolicy::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Visitor::PrivacyPolicy::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Visitor::CookiesPolicy::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Visitor::CookiesPolicy::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Visitor::PrivacySettings::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Visitor::PrivacySettings::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::User::Create::Form::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::User::Create::Form::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::User::Create::Verification::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::User::Create::Verification::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::User::Create::Confirmation::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::User::Create::Confirmation::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::User::Edit::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::User::Edit::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::User::ResetPassword::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::User::ResetPassword::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::User::Authorize::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::User::Authorize::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Listing::Create::Form::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Listing::Create::Form::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Listing::Show::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Listing::Show::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Listing::Edit::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Listing::Edit::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Listing::Promote::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Listing::Promote::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Page::Index::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Page::Index::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Page::Show::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Page::Show::Appender.new(**attrs, page: page).call
          when ::MapawynajmuPl::Api::Tracks::Page::Edit::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Page::Edit::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Image::Edit::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Image::Edit::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Image::Index::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Image::Index::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Assets::Index::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Assets::Index::Appender.new(attrs).call
          when ::MapawynajmuPl::Api::Tracks::Redirects::Index::Meta::TRACK then ::MapawynajmuPl::Api::Tracks::Redirects::Index::Appender.new(attrs).call  
          when ::Api::Tracks::Redirect::Show::Meta::TRACK then ::Api::Tracks::Redirect::Show::Appender.new(attrs).call
          end
        end

        def append_links
          links = state[:links] || {}
          state[:links] = links.merge(
            ::MapawynajmuPl::Api::Tracks::Root::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Root::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Visitor::Contact::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::Contact::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Visitor::TermsOfService::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::TermsOfService::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Visitor::PrivacyPolicy::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::PrivacyPolicy::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Visitor::CookiesPolicy::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::CookiesPolicy::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Visitor::PrivacySettings::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::PrivacySettings::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Visitor::Page::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Visitor::Page::Index::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::User::Create::Form::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Create::Form::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::User::Create::Verification::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Create::Verification::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::User::Edit::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Edit::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::User::ResetPassword::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::ResetPassword::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::User::Authorize::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Authorize::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::User::Show::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::User::Show::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Listing::Create::Form::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Create::Form::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Page::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Page::Index::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Image::Edit::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Image::Edit::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::Image::Index::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::Image::Index::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::SocialPages::Facebook::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::SocialPages::Facebook::Linker.new(lang).call,
            ::MapawynajmuPl::Api::Tracks::SocialPages::Linkedin::Meta::TRACK => ::MapawynajmuPl::Api::Tracks::SocialPages::Linkedin::Linker.new(lang).call,
          )
        end

        def append_track_not_found_data
          ::MapawynajmuPl::Api::Tracks::Page::NotFound::Appender.new(attrs).call
        end
      end
    end
  end
end
