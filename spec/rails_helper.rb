ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'support/easy_screenshots'
require 'support/sign_up_and_login'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_driver    = :poltergeist

ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.add_setting :screenshots_dir
  config.screenshots_dir = "#{::Rails.root}/spec/screenshots"
  config.include(EasyScreenshots, type: :feature)
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Devise::TestHelpers, type: :controller)

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    #ActiveRecord::Base.connection.execute %{SET session_replication_role = replica}
  end
  config.after(:suite) do
    #ActiveRecord::Base.connection.execute %{SET session_replication_role = DEFAULT}
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :type => :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def create_states
  State.destroy_all
  State.create!(name: "Alabama"           , code: "AL")
  State.create!(name: "Alaska"            , code: "AK")
  State.create!(name: "Arizona"           , code: "AZ")
  State.create!(name: "Arkansas"          , code: "AR")
  State.create!(name: "California"        , code: "CA")
  State.create!(name: "Colorado"          , code: "CO")
  State.create!(name: "Connecticut"       , code: "CT")
  State.create!(name: "Delaware"          , code: "DE")
  State.create!(name: "Dist. of Columbia" , code: "DC")
  State.create!(name: "Florida"           , code: "FL")
  State.create!(name: "Georgia"           , code: "GA")
  State.create!(name: "Hawaii"            , code: "HI")
  State.create!(name: "Idaho"             , code: "ID")
  State.create!(name: "Illinois"          , code: "IL")
  State.create!(name: "Indiana"           , code: "IN")
  State.create!(name: "Iowa"              , code: "IA")
  State.create!(name: "Kansas"            , code: "KS")
  State.create!(name: "Kentucky"          , code: "KY")
  State.create!(name: "Louisiana"         , code: "LA")
  State.create!(name: "Maine"             , code: "ME")
  State.create!(name: "Maryland"          , code: "MD")
  State.create!(name: "Massachusetts"     , code: "MA")
  State.create!(name: "Michigan"          , code: "MI")
  State.create!(name: "Minnesota"         , code: "MN")
  State.create!(name: "Mississippi"       , code: "MS")
  State.create!(name: "Missouri"          , code: "MO")
  State.create!(name: "Montana"           , code: "MT")
  State.create!(name: "Nebraska"          , code: "NE")
  State.create!(name: "Nevada"            , code: "NV")
  State.create!(name: "New Hampshire"     , code: "NH")
  State.create!(name: "New Jersey"        , code: "NJ")
  State.create!(name: "New Mexico"        , code: "NM")
  State.create!(name: "New York"          , code: "NY")
  State.create!(name: "North Carolina"    , code: "NC")
  State.create!(name: "North Dakota"      , code: "ND")
  State.create!(name: "Ohio"              , code: "OH")
  State.create!(name: "Oklahoma"          , code: "OK")
  State.create!(name: "Oregon"            , code: "OR")
  State.create!(name: "Pennsylvania"      , code: "PA")
  State.create!(name: "Rhode Island"      , code: "RI")
  State.create!(name: "South Carolina"    , code: "SC")
  State.create!(name: "South Dakota"      , code: "SD")
  State.create!(name: "Tennessee"         , code: "TN")
  State.create!(name: "Texas"             , code: "TX")
  State.create!(name: "Utah"              , code: "UT")
  State.create!(name: "Vermont"           , code: "VT")
  State.create!(name: "Virginia"          , code: "VA")
  State.create!(name: "Washington"        , code: "WA")
  State.create!(name: "West Virginia"     , code: "WV")
  State.create!(name: "Wisconsin"         , code: "WI")
  State.create!(name: "Wyoming"           , code: "WY")
end