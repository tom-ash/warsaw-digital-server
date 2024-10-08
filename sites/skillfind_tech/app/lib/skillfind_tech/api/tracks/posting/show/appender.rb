# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Posting
        module Show
          class Appender < ::SkillfindTech::Api::Tracks::Common::Appender
            include ::SkillfindTech::Api::Tracks::Posting::Show::State
            include ::SkillfindTech::Api::Tracks::Posting::Show::Meta
            include ::SkillfindTech::Api::Tracks::Posting::Common::Skills
            include ::SkillfindTech::Api::Tracks::Posting::Common::Postings
            include ::SkillfindTech::Api::Tracks::Posting::Common::Industries
            include ::SkillfindTech::Api::Tracks::Posting::Common::Currencies

            private

            def rootLocalizations
              @rootLocalizations ||= getLocalizations("sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/root/localizations/#{lang}.json")
            end

            def localizations
              @localizations ||= getLocalizations("sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/posting/show/localizations/#{lang}.json")
            end

            def texts
              rootLocalizations.merge(localizations)
            end

            def control
              {
                isPinsDrawn: false,
                mapOptions: {
                  center: {
                    lat: posting.lat,
                    lng: posting.lng,
                  },
                  zoom: 9,
                },
              }
            end

            def data
              {
                postings: postings,
                pages: [], # TODO!
                articles: [], # TODO!
                posting: serializedPosting,
                currentListingId: posting.id, # TODO!
              }
            end

            def postingId
              @postingId ||= match_data[:posting_id]
            end

            def posting
              @posting ||= ::SkillfindTech::Posting.includes(:user).find(postingId)
            end

            def inputs
              {
                selectableSkills: selectableSkills,
                selectedSkills: selectedSkills,
              }
            end

            def serializedPosting
              @serializedPosting ||= {
                id: posting.id,
                logo: "https://#{ENV['SKILLFIND_TECH_AWS_S3_BUCKET']}.s3.eu-central-1.amazonaws.com/logos/#{posting.user.logo}",
                businessName: posting.user.business_name,
                industry: localizedIndustry(posting.user.industry),
                skills: postingSelectedSkills(posting),
                b2b: posting.b2b,
                b2bMin: posting.b2b_min,
                b2bMax: posting.b2b_max,
                b2bCurrency: posting.b2b_currency ? getCurrency(posting.b2b_currency) : nil,
                employment: posting.employment,
                employmentMin: posting.employment_min,
                employmentMax: posting.employment_max,
                employmentCurrency: posting.employment_currency ? getCurrency(posting.employment_currency) : nil,
                country: posting.country,
                locality: posting.locality,
                sublocality: posting.sublocality,
                cooperationMode: localizedCooperationMode(posting.cooperation_mode),
                lat: posting.lat,
                lng: posting.lng,
                description: posting["#{lang}_description"],
                application_link: posting.application_link,
                poster_link: poster_link,
                position: posting.position,
              }
            end

            def poster_link
              @poster_link ||= begin
                return if posting.user.link.blank?

                if posting.user.link.include?('https')
                  return posting.user.link
                end

                "https://#{posting.user.link}"
              end
            end

            def industry
              @industry ||= getIndustry(posting.user.industry)
            end

            def image
              "https://#{ENV['SKILLFIND_TECH_AWS_S3_BUCKET']}.s3.eu-central-1.amazonaws.com/postings/#{posting.id}/image.png"
            end

            def asset_names
              @asset_names ||= %i[
                at
                minus
                marker
                building
                earthGlobe
                treeCity
                plus
                arrowRight
                magnifyingGlass
                moneyTransfer
                quoteLeft
                hourglass
                arrowLong
                dot
                emptyDot
                close
              ] + industryIcons + header_asset_names
            end

            def links
              {
                'current/en': {
                  href: posting_href(posting, :en),
                  hrefLang: :en,
                  # title,
                },
                'current/pl': {
                  href: posting_href(posting, :pl),
                  hrefLang: :pl,
                  # title,
                },
              }
            end
          end
        end
      end
    end
  end
end
