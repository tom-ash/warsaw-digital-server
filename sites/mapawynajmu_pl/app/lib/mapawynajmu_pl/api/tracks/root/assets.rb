# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Root
        module Assets
          def asset_names
            @asset_names ||= %i[
              # filters
              list
              area
              coins

              # pins
              apartment
              room
              house
              parkingSpace
              garage
              usablePremises
              office
              virtualOffice
              coworkingSpace
              advertisingSpaces

              marker

              # check
              facebook
              chevron
              calendar
              close
              phone
              caretDown
              arrowRight

              facebook_square
              linkedin_square
              twitter_square
            ]
          end
        end
      end
    end
  end
end
