# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Listing
      module Create
        class AsUser < Grape::API
          helpers MapawynajmuPl::Api::Listing::Helpers::Attrs

          before { authorize! }

          params { use :announcement_attrs }
          post do
            ::MapawynajmuPl::Commands::Listing::Create.new(
              user_id: authenticated_user.id,
              attrs: params[:announcement].merge(user_verified: true),
            ).call
            authenticated_user.announcements.last.summary_path(lang)
          end
        end
      end
    end
  end
end