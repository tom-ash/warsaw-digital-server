# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Posting
        module Create
          module Form
            class Appender < ::SkillfindTech::Api::Tracks::Common::Appender
              include ::SkillfindTech::Api::Tracks::Posting::Create::Form::State
              include ::SkillfindTech::Api::Tracks::Posting::Create::Form::Meta
              include ::SkillfindTech::Api::Tracks::Posting::Common::Postings
              include ::SkillfindTech::Api::Tracks::Posting::Common::Industries
              include ::SkillfindTech::Api::Tracks::Posting::Common::CooperationMode

              EMPTY_TEXT = ''

              def localizations
                @localizations ||= user_localizations.merge(getLocalizations("sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/posting/create/form/localizations/#{lang}.json"))
              end

              def user_localizations
                @user_localizations ||= getLocalizations("sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/user/new/form/localizations/#{lang}.json")
              end

              def texts
                localizations.merge(user_form_texts)
              end
              
              def data
                {
                  industries: localizedIndustries,
                  cooperationModes: localizedCooperationModes,
                }
              end

              def control
                {
                  mapOptions: {
                    center: {
                      lat: 42,
                      lng: 12,
                    },
                    zoom: 1.6,
                  },
                }
              end

              def inputs
                {
                  businessName: EMPTY_TEXT,
                  selectableSkills: selectableSkills,
                  selectedSkills: [],
                  description: EMPTY_TEXT,
                  b2b: false,
                  b2bMin: EMPTY_TEXT,
                  b2bMax: EMPTY_TEXT,
                  b2bCurrency: 'pln',
                  b2bCurrencySelectOptions: ::SkillfindTech::Api::Tracks::Posting::Common::Currencies::CURRENCIES,
                  employment: false,
                  employmentMin: EMPTY_TEXT,
                  employmentMax: EMPTY_TEXT,
                  employmentCurrency: 'pln',
                  employmentCurrencySelectOptions: ::SkillfindTech::Api::Tracks::Posting::Common::Currencies::CURRENCIES,
                  cooperationMode: 'office',
                  cooperationModeRadio: {
                    name: 'cooperation_mode',
                    options: localizations[:cooperationModeOptions]
                  },
                  contracts: contracts,
                  formApplicationManner: false,
                  linkApplicationManner: false,
                  applicationLink: HTTPS_PROTOCOL_PREFIX,
                }.merge(user_form_inputs)
              end

              def contracts
                @contracts ||= localizations[:contracts]
              end

              def currencies
                [
                  {
                    value: 'pln',
                    text: 'PLN',
                  },
                  {
                    value: 'eur',
                    text: 'EUR',
                  },
                  {
                    value: 'usd',
                    text: 'USD',
                  },
                ]
              end

              def errors
                {
                  businessNameError: EMPTY_TEXT,
                  applicationLink: EMPTY_TEXT,
                }.merge(user_form_errors)
              end

              def selectableSkills
                @selectableSkills ||= ::SkillfindTech::Skill.all.map do |skill|
                  {
                    value: skill['value'],
                    display: skill[lang],
                    queryParam: skill["route_#{lang}"],
                  }
                end
              end

              def asset_names
                @asset_names ||= %i[
                  at
                  minus
                  chevron
                  camera
                  close
                  plus
                  magnifyingGlass
                  arrowRight
                  dot
                  emptyDot
                ] + header_asset_names + postingAssets + industryIcons
              end
            end
          end
        end
      end
    end
  end
end
