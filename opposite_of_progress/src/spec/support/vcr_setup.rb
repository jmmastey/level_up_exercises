VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/cassettes'
  c.hook_into :webmock

  c.filter_sensitive_data('<SUNLIGHT_CONGRESS_API_KEY>') do
    ENV['SUNLIGHT_CONGRESS_API_KEY']
  end
end
