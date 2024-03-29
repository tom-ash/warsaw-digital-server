# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Posting
        module Create
          module Summary
            module Meta
              TRACK = 'announcement/create/summary'

              UNLOCALIZED_PATH = {
                en: %r{^posted-job/(\d+)$}
              }.freeze

              UNLOCALIZED_TITLE = {
                en: 'TODO'
              }.freeze

              private

              def id
                @id ||= unlocalized_path[lang].match(url)[1]
              end

              def announcement
                @announcement ||= ::SkillfindTech::Posting.find(id)
              end

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
                  en: 'TODO'
                }.freeze
              end

              def unlocalized_description
                @unlocalized_description ||= {
                  en: 'TODO'
                }.freeze
              end

              def render
                {
                  'visitor': true,
                  'announcement': true,
                  'announcement/create': true,
                  'announcement/create/summary': true
                }
              end
            end
          end
        end
      end
    end
  end
end
