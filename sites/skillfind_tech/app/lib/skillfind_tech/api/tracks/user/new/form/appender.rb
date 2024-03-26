# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module User
        module New
          module Form
            class Appender < ::SkillfindTech::Api::Tracks::Common::Appender
              include ::SkillfindTech::Api::Tracks::User::New::Form::State
              include ::SkillfindTech::Api::Tracks::User::New::Form::Meta

              private
              
              def localizations
                @localizations ||= getTexts("sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/user/new/form/localizations/#{lang}.json")
              end
            end
          end
        end
      end
    end
  end
end
