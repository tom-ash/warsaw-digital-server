# frozen_string_literal: true

# PROD
SKILLFIND_TECH_NAME = 'skillfind.tech'
SKILLFIND_TECH_NAME_CONSTANTIZED_NAME = 'SkillfindTech'
SKILLFIND_TECH_NAME_APEX_DOMAIN = 'skillfind.tech'
SKILLFIND_TECH_DOMAIN = SKILLFIND_TECH_NAME_APEX_DOMAIN
SKILLFIND_TECH_NAME_LANGS = %i[en pl].freeze
SKILLFIND_TECH_URL = "https://#{SKILLFIND_TECH_DOMAIN}"
SKILLFIND_TECH_S3 = ENV['AWS_S3_SOUNDOFIT_BUCKET']
SKILLFIND_TECH_IMAGE = 'https://soundofit.s3.eu-central-1.amazonaws.com/soundof.it.jpeg'
SKILLFIND_TECH_API_URL = 'https://warsaw-digital-server.herokuapp.com/skillfind_tech'

MAPAWYNAJMU_PL_NAME = 'mapawynajmu.pl'
MAPAWYNAJMU_PL_CONSTANTIZED_NAME = 'MapawynajmuPl'
MAPAWYNAJMU_PL_APEX_DOMAIN = 'mapawynajmu.pl'
MAPAWYNAJMU_PL_DOMAIN = MAPAWYNAJMU_PL_APEX_DOMAIN
MAPAWYNAJMU_PL_NAME_LANGS = %i[pl en].freeze
MAPAWYNAJMU_PL_URL = "https://#{MAPAWYNAJMU_PL_DOMAIN}"
MAPAWYNAJMU_PL_S3 = ENV['AWS_S3_MAPAWYNAJMUPL_BUCKET']
MAPAWYNAJMU_PL_IMAGE = 'https://mapawynajmupl.s3.eu-central-1.amazonaws.com/assets/images/mapawynajmupl.jpg'
MAPAWYNAJMU_PL_API_URL = 'https://warsaw-digital-server.herokuapp.com/mapawynajmu-pl'

SENTRY_URL = 'https://2940536e6132431996571db68fd3a5b1@o876363.ingest.sentry.io/4504761826476032'

# DEV
SKILLFIND_TECH_DOMAIN_DEV = 'local.skillfind.tech:8080'
SKILLFIND_TECH_URL_DEV = "http://#{SKILLFIND_TECH_DOMAIN_DEV}"
SKILLFIND_TECH_API_URL_DEV = 'http://localhost:3001/skillfind_tech'

MAPAWYNAJMU_PL_DOMAIN_DEV = 'local.mapawynajmu.pl:8080'
MAPAWYNAJMU_PL_URL_DEV = "http://#{MAPAWYNAJMU_PL_DOMAIN_DEV}"
MAPAWYNAJMU_PL_API_URL_DEV = 'http://localhost:3001/mapawynajmu-pl'

SENTRY_URL_DEV = 'https://21c5d785943440029a34371f8cdbca32@o876363.ingest.sentry.io/5825780'

EMPTY_STRING = ''
EMPTY_ARRAY = ''