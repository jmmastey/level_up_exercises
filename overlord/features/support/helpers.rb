def host_url
  @host = ENV['TEST_HOST'] ? ENV['TEST_HOST'] : "localhost:4567"
  overlord_url = @host.start_with?('http') ? @host : "http://#{@host}"
  @overlord_url = "#{overlord_url}"
end
