# frozen_string_literal: true

module Api
  module Tracks
    module Common
      module State
        private

        def merge_state
          state.merge!(
            render: render,
            user: user,
            texts: texts.merge(common_texts),
            assets: { svgs: assets },
            links: links,
            control: control,
            data: data,
            inputs: inputs,
            errors: errors,
          )
        end

        def state
          @state ||= attrs[:state]
        end

        def render
          {}
        end

        def user
          return blank_user if authenticated_user.blank?

          ::Serializers::User::Show.new(user: authenticated_user, constantized_site_name: constantized_site_name).call
        end

        def blank_user
          {
            authorized: false,
            accountType: nil,
            role: nil,
          }
        end

        def texts
          {}
        end

        def assets
          ::MapawynajmuPl::Asset.where(name: shared_asset_names.concat(asset_names)).each_with_object({}) do |svg, serialized_svgs|
            serialized_svgs[svg.name.to_s] = { path_data: svg.path_data, view_box: svg.view_box }
          end
        end

        def links
          {}
        end

        def control
          {}
        end

        def data
          {}
        end

        def inputs
          {}
        end

        def errors
          {}
        end

        def authenticated_user
          @authenticated_user ||= attrs[:authenticated_user]
        end

        def shared_asset_names
          @shared_asset_names ||= %w[
            chevron
            facebook_square
            linkedin_square
            twitter_square
          ]
        end

        def asset_names
          @asset_names ||= []
        end

        def common_texts
          {
            pl: {
              signOutButtonLabel: 'Wyloguj',
              showMyAccountMenuButtonLabel: 'Moje konto',
              allRightsReserved: '',
            },
            en: {
              signOutButtonLabel: 'Sign Out',
              showMyAccountMenuButtonLabel: 'My account',
              allRightsReserved: '',
            },
          }[lang]
        end
      end
    end
  end
end
