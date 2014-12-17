VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end
