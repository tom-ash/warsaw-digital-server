# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module User
        module Users
          module Edit
            module Meta
              include ::Helpers::MetaLocalizations

              TRACK = 'user/users/edit'

              UNLOCALIZED_PATH = {
                en: 'account',
                pl: 'pl/konto',
              }.freeze

              private

              def label
                {
                  en: 'Settings',
                  pl: 'Ustawienia',
                }[lang]
              end

              def icon
                'cog'
              end

              def track
                @track ||= TRACK
              end

              def unlocalized_path
                @unlocalized_path ||= UNLOCALIZED_PATH
              end

              def metaLozalizationPath
                @metaLozalizationPath ||= "sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/user/users/edit/localizations/meta/#{lang}.json"
              end

              def render
                {
                  'user/users/edit': true,
                }
              end

              def links
                {
                  'current/en': ::SkillfindTech::Api::Tracks::User::Users::Edit::Linker.new(:en).call,
                  'current/pl': ::SkillfindTech::Api::Tracks::User::Users::Edit::Linker.new(:pl).call,
                }
              end
            end
          end
        end
      end
    end
  end
end
