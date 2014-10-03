require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = 'vcr/cassettes'
  c.hook_into :webmock
end

Given(/^I am using VCR cassette "([A-Za-z_]+)"$/) do |cassette_name|
  @cassette_name = cassette_name
end
