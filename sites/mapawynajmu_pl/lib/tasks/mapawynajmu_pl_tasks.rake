# frozen_string_literal: true

namespace :mapawynajmu_pl do
  desc 'Populate PathData & ViewBox'
  task populate_path_data_and_view_box: :environment do
    ::MapawynajmuPl::Asset.all.each do |asset|
      asset.path_data = asset.data['pathData']
      asset.view_box = asset.data['viewBox']
      asset.save!
    end
  end

  desc 'Transform Page Bodies'
  task transform_page_bodies: :environment do
    ::MapawynajmuPl::Page.all.each do |page|
      ::Commands::Page::TransformBody.new(
        page: page,
        constantized_site_name: 'MapawynajmuPl',
        bucket: ENV['AWS_S3_MAPAWYNAJMUPL_BUCKET']
      ).call
    end
  end

  desc 'Soft delete inactive listings.'
  task delete_inactive_announcements: :environment do
    ::MapawynajmuPl::Listing.where('active_until < ?', 1.day.ago).each do |listing|
      listing.soft_delete!
    end
  end

  desc 'MapawynajmuPl Grape Routes'
  task routes: :environment do
    ::MapawynajmuPl::Api::Base.routes.each do |api|
      method = api.request_method.ljust(10)
      path = api.path
      puts "#{method} #{path}"
    end
  end

  desc 'Prepares user verification for new user architecture.'
  task prepare_user_verification: :environment do
    ::MapawynajmuPl::User.all.each do |user|
      user.update!(verification: []) if user.verification&.class != Array
    end
  end

  desc 'Generate encryption :key, :iv and :salt.'
  task generate_encryption_key_iv_and_salt: :environment do
    { key: 32, iv: 16, salt: 128 }.each do |k, length|
      puts "#{k}: \"#{Base64.encode64(SecureRandom.random_bytes(length)).delete("\n")}\""
    end
  end

  desc 'Update Page Schemas'
  task update_page_schemas: :environment do
    ::MapawynajmuPl::Page.all.each do |page|
      ::Builders::Pages::SchemaOrgBuilder.new(
        page: page,
        domain_url: MAPAWYNAJMU_PL_URL,
        bucket: MAPAWYNAJMU_PL_AWS_S3_BUCKET
      ).call
    end
  end
end
