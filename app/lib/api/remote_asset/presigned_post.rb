# frozen_string_literal: true

module Api
  module RemoteAsset
    class PresignedPost < Grape::API
      params do
        requires :path, type: String
        requires :key, type: String
        requires :randomize_key, type: Boolean
        requires :file_type, type: String
        requires :mime_type, type: String
      end
      post do
        path = "#{params[:path]}/"
        uuid = params[:randomize_key] ? "#{SecureRandom.uuid}-" : ''
        requested_key = params[:key]
        file_type = params[:file_type]
        trailing_key = "#{uuid}#{params[:key].parameterize}.#{file_type}"
        key = "#{path}#{trailing_key}"
        mime_type = params[:mime_type]

        post = Aws::S3::PresignedPost.new(
          CREDS,
          'eu-central-1',
          Rails.application.secrets.aws_bucket,
          key: key,
          success_action_status: '201',
          content_type: mime_type,
        )

        {
          fields: post.fields,
          url: post.url,
          trailingKey: trailing_key,
        }
      end
    end
  end
end
