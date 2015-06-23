require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = "vcr_cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {:record => :once}
end
