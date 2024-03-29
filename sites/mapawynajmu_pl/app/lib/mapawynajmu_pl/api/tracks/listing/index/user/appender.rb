# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Listing
        module Index
          module User
            class Appender < ::MapawynajmuPl::Api::Tracks::Common::Appender
              include ::MapawynajmuPl::Api::Tracks::Listing::Index::User::Meta

              private

              def authorize!
                raise ::Api::UnauthorizedError unless authenticated_user.present?
              end

              def texts
                {
                  pl: {
                    promoteButtonLabel: 'Wyróżnij ogłoszenie',
                    shareOnFacebookButtonLabel: 'Udostępnij na Facebook\'u',
                    activeUntilLabel: 'Aktywne do',
                    activeUntilNotApplicableLabel: 'Ogłoszenie jest aktywne bezterminowo.',
                    activeUntilExtendButtonLabel: 'Przedłuż',
                  },
                  en: {
                    promoteButtonLabel: 'Promote the Listing',
                    shareOnFacebookButtonLabel: 'Share on Facebook',
                    activeUntilLabel: 'Active until',
                    activeUntilNotApplicableLabel: 'The listing is active indefinitely.',
                    activeUntilExtendButtonLabel: 'Extend',
                  },
                }[lang]
              end

              def data
                {
                  announcements: serialized_announcements,
                  amount: serialized_announcements.count,
                }
              end

              def announcements
                ::MapawynajmuPl::Queries::Listing::Index::User.new(user_id: authenticated_user.id).call
              end

              def serialized_announcements
                ::MapawynajmuPl::Serializers::Listing::Index::User.new(announcements, lang).call
              end
            end
          end
        end
      end
    end
  end
end
