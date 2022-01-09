# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module User
        module Edit
          module Meta
            TRACK = 'user/edit'

            UNLOCALIZED_PATH = {
              pl: 'ustawienia-konta',
              en: 'account-settings'
            }.freeze

            UNLOCALIZED_TITLE = {
              pl: 'Ustawienia Konta',
              en: 'Account Settings'
            }.freeze

            private

            def track
              @track ||= TRACK
            end

            def unlocalized_path
              @unlocalized_path ||= UNLOCALIZED_PATH
            end

            def unlocalized_title
              @unlocalized_title ||= UNLOCALIZED_TITLE
            end

            def unlocalized_keywords
              @unlocalized_keywords ||= {
                pl: 'konto, ustawienia, użytkownik, warsawlease.pl, ogłoszenia, wynajem, nieruchomości, warszawa',
                en: 'account, settings, user, warsawlease.pl, announcement, lease, real estate, warsaw'
              }.freeze
            end

            def unlocalized_description
              @unlocalized_description ||= {
                pl: 'Ustawienia konta na warsawlease.pl - serwisu z ogłoszeniami wynajmu nieruchomości w Warszawie.',
                en: 'Account settings on warsawlease.pl - a service featuring real estate lease announcements in Warsaw.'
              }.freeze
            end

            def render
              {
                visitor: true,
                user: true,
                'user/edit': true
              }
            end

            def links
              {
                'current/pl': ::MapawynajmuPl::Api::Tracks::User::Edit::Linker.new(:pl).call,
                'current/en': ::MapawynajmuPl::Api::Tracks::User::Edit::Linker.new(:en).call
              }
            end
          end
        end
      end
    end
  end
end