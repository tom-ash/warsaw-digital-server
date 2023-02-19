# frozen_string_literal: true

module Api
  module Tracks
    module Helpers
      module Appender
        class UnauthorizedError < StandardError; end

        def initialize(attrs)
          @attrs = attrs
        end

        def call
          authorize!
          merge_state
          merge_meta
        end

        private

        attr_reader :attrs

        def authorize!; end

        def state
          @state ||= attrs[:state]
        end

        def meta
          @meta ||= attrs[:meta]
        end

        def merge_state
          state.merge!(
            render: render,
            user: user,
            texts: texts,
            assets: { svgs: assets },
            links: links,
            control: control,
            data: data,
            inputs: inputs,
            errors: errors,
          )
        end

        def merge_meta
          meta.merge!(
            langs: langs,
            title: title,
            keywords: keywords,
            description: description,
            image: image,
            schema: schema,
            open_graph: open_graph,
            robots: robots,
            canonical_url: canonical_url,
            alternate_links: alternate_links,
          )
        end

        def render
          {}
        end

        def user
          return {} if current_user.blank?

          ::Serializers::User::Show.new(user: current_user, constantized_site_name: constantized_site_name).call
        end

        def texts
          {}
        end

        def assets
          ::MapawynajmuPl::Asset.where(name: asset_names).each_with_object({}) do |svg, serialized_svgs|
            serialized_svgs[svg.name.to_s] = svg.data
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

        def alternate_links
          alternate_links_string = ''

          langs.map do |lang|
            href = links["current/#{lang}".to_sym][:path]
            alternate_links_string += "<link rel=\"alternate\" hreflang=\"#{lang}\" href=\"#{domain_url}#{href == '' ? '' : '/'}#{href}\" />"
          end

          alternate_links_string
        end

        def robots
          @robots ||= 'index,follow,all'
        end

        def canonical_url
          @canonical_url ||= full_url
        end

        def open_graph
          @open_graph ||= ::Builders::OpenGraph.new(
            site_name: attrs[:site_name],
            url: full_url,
            title: title,
            description: description,
            keywords: keywords,
            image: image,
            locale: lang,
            locale_alts: langs,
          ).call
        end

        def lang
          @lang ||= attrs[:lang].to_sym
        end

        def langs
          @langs ||= attrs[:langs]
        end

        def schema
          @schema ||= ::Builders::SchemaOrg.new(schema_data).call
        end

        def schema_data
          @schema_data ||= {
            url: full_url,
            title: title,
            description: description,
            keywords: keywords,
            image: image,
            lang: lang,
          }
        end

        def current_user
          @current_user ||= attrs[:current_user]
        end

        def url
          @url ||= attrs[:url]
        end

        def domain_url
          @domain_url ||= attrs[:domain_url]
        end

        def full_url
          @full_url ||= domain_url + (url == '/' ? '' : "/#{url}")
        end

        def params
          @params ||= attrs[:params]
        end

        def site
          @site ||= attrs[:site]
        end

        def constantized_site_name
          @constantized_site_name ||= attrs[:constantized_site_name]
        end

        def title
          @title ||= unlocalized_title[lang]
        end

        def description
          @description ||= unlocalized_description[lang]
        end

        def keywords
          @keywords ||= unlocalized_keywords[lang]
        end

        def lang_counterpart
          @lang_counterpart ||= lang == :pl ? :en : :pl
        end

        def asset_names
          @asset_names ||= []
        end

        def image
          @image ||= attrs[:image]
        end

        def ssr?
          @ssr ||= attrs[:is_ssr]
        end
      end
    end
  end
end
