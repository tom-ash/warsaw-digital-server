# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Listing
      module Update
        class Views < Grape::API
          params { requires :id, type: Integer }
          put do
            current_announcement.update_attribute(:views, current_announcement.views + 1)
          end
        end
      end
    end
  end
end
