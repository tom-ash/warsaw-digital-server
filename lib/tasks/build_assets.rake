# frozen_string_literal: true

require 'open-uri'
require 'optparse'

task build_assets: :environment do
  ASSETS_URI = ENV['WARSAWLEASEPL_ASSETS']

  ARGV.each { |a| task a.to_sym }

  site = ARGV[1].capitalize

  return unless site.present?

  Object.const_get(site)::Asset.destroy_all

  # Prod
  assets = JSON.load(URI.open(ASSETS_URI))

  # Local
  # assets_file = File.open '../../Assets/assets_20210515.json'
  # assets = JSON.load(assets_file)

  assets.each do |name, attrs|
    Object.const_get(site)::Asset.create( name: name, type: "#{site}::#{attrs['type']}", data: attrs['data'])
  end
end

# t.bigint "principal_skill_id"
# t.string "name", null: false
# t.string "type", null: false
# t.text "description"

# skills = [
#   {
#     name: 'JavaScript',
#     type: 'SkillfindTech::Language',
#   },

# ]

# task build_skills: :environment do
#   skills.each do |skill|

#     ::SkillfindTech::Skill.create(skill)

#   end

#   # ASSETS_URI = ENV['WARSAWLEASEPL_ASSETS']

#   # ARGV.each { |a| task a.to_sym }

#   # site = ARGV[1].capitalize

#   # return unless site.present?

#   # Object.const_get(site)::Asset.destroy_all

#   # # Prod
#   # assets = JSON.load(URI.open(ASSETS_URI))

#   # # Local
#   # # assets_file = File.open '../../Assets/assets_20210515.json'
#   # # assets = JSON.load(assets_file)

#   # assets.each do |name, attrs|
#   #   Object.const_get(site)::Asset.create( name: name, type: "#{site}::#{attrs['type']}", data: attrs['data'])
#   # end
# end
