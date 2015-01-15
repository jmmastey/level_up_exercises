require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
  c.ignore_localhost = true
end


VCR.cucumber_tags do |t|
  t.tag '@congress_api', use_scenario_name: true
end
