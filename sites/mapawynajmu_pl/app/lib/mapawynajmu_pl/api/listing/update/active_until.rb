# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Listing
      module Update
        class ActiveUntil < Grape::API
          before { authorize_for_announcement! }

          params { requires :id, type: Integer }

          put do
            active_until = Date.today + 60.days
            current_announcement.update_attribute(:active_until, active_until)
            camelize(::MapawynajmuPl::Serializers::Listing::Edit.new(current_announcement).call)
          end
        end
      end
    end
  end
end
