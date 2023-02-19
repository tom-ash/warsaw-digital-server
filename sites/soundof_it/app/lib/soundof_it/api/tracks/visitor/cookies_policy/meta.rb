# frozen_string_literal: true

module SoundofIt
  module Api
    module Tracks
      module Visitor
        module CookiesPolicy
          module Meta
            TRACK = 'visitor/cookies-policy'

            UNLOCALIZED_PATH = {
              en: 'cookies-policy',
              pl: 'polityka-cookies',
            }.freeze

            UNLOCALIZED_TITLE = {
              en: 'Cookies Policy',
              pl: 'Polityka Cookies',
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
                en: 'cookies policy, soundof.IT, IT, dev, programming, board, job, knowledge, repository',
                # TODO: Add :pl!
              }.freeze
            end

            def unlocalized_description
              @unlocalized_description ||= {
                en: 'Cookies Policy of soundof.IT, an IT skill driven job board & knowledge repository.',
                # TODO: Add :pl!
              }.freeze
            end

            def render
              {
                'visitor': true,
                'visitor/cookies-policy': true,
              }
            end

            def links
              {
                'current/en': ::SoundofIt::Api::Tracks::Visitor::CookiesPolicy::Linker.new(:en).call,
                'current/pl': ::SoundofIt::Api::Tracks::Visitor::CookiesPolicy::Linker.new(:pl).call,
              }
            end
          end
        end
      end
    end
  end
end
