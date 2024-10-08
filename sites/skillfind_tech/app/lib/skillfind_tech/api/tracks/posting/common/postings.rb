# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Posting
        module Common
          module Postings
            private

            def selectedPostingIds
              @selectedPostingIds ||= begin
                if (selectedSkills.length > 0)
                  whereArray = []
                  whereDataArray = []
                  whereString = nil
                  arr = nil
                  
                  selectedSkills.map do |selectedSkill|
                    whereArray << "(route_#{lang} = ? AND level <= ?)"
                    whereString = whereArray.join(' OR ')
                    whereDataArray << selectedSkill[:queryParam]
                    whereDataArray << (selectedSkill[:level] == '0' ? '5' : selectedSkill[:level])
  
                    arr = [whereString] + whereDataArray
                  end
  
                  return ::SkillfindTech::SelectedSkill.joins(:skill)
                    .where(*arr)
                    .group(:posting_id).having("count(posting_id) = #{selectedSkills.length}")
                    .select(:posting_id)
                end
              end
            end

            def postings
              if selectedPostingIds
                postings = ::SkillfindTech::Posting.where(id: selectedPostingIds.map(&:posting_id))
              else
                postings = ::SkillfindTech::Posting
              end

              if postings_user_id
                postings = postings.where(user_id: postings_user_id)
              end
  
              postings
              .includes(:skills)
              .includes(:user)
              .where(deleted_at: nil)
              .where(verified: true)
              .order('active_until DESC NULLS LAST')
              .map do |posting|
                industry = getIndustry(posting.user.industry)

                {
                  logo: "https://#{ENV['SKILLFIND_TECH_AWS_S3_BUCKET']}.s3.eu-central-1.amazonaws.com/logos/#{posting.user.logo}",
                  businessName: posting.user.business_name,
                  industry: industry[lang.to_s],
                  industryIcon: industry['icon'],
                  id: posting.id,
                  href: posting_href(posting, lang),
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
                  active_until: posting.active_until,
                  position: posting.position,
                  created_at: posting.created_at,
                  # active_until: posting.active_until
                  # formattedCreatedAt: posting.created_at.to_formatted_s(:db),
                }
              end
            end

            def posting_href(posting, lang)
              "#{posting_prefix(lang)}/#{posting.id}#{path_suffix(posting, lang)}"
            end

            def posting_prefix(lang)
              lang != :en ? "/#{lang}" : ''
            end

            def path_suffix(posting, lang)
              path_suffix_string = ''

              postingSelectedSkills(posting).map do |skill|
                path_suffix_string = path_suffix_string + "-#{skill["route_#{lang}"]}-#{skill_levels[skill[:level] - 1][lang]}"
              end

              path_suffix_string.downcase
            end

            def skill_levels
              [
                { en: 'Junior', pl: 'Junior' },
                { en: 'Mid', pl: 'Mid' },
                { en: 'Senior', pl: 'Senior' },
                { en: 'Expert', pl: 'Ekspert' },
              ]
            end
  
            def postingSelectedSkills(posting)
              posting.selected_skills.map do |selected_skill|
                {
                  value: selected_skill.skill.value,
                  display: selected_skill.skill[lang],
                  level: selected_skill.level,
                }
              end
            end

            def localizedCooperationMode(cooperationMode)
              localizedCooperationModes.find do |mode|
                mode[:value] == cooperationMode
              end
            end

            def localizedCooperationModes
              @localizedCooperationModes ||= getLocalizations("sites/skillfind_tech/app/lib/skillfind_tech/api/tracks/posting/common/localizations/cooperation-modes/#{lang}.json")[:cooperationModes]
            end

            def postings_user_id
              nil
            end

            def postingAssets
              %i[
                marker
                office
                building
                treeCity
              ]
            end
          end
        end
      end
    end
  end
end
