def host_url
  @host = ENV['TEST_HOST'] ? ENV['TEST_HOST'] : "localhost:4567"
  overlord_url = @host.start_with?('http') ? @host : "http://#{@host}"
  @overlord_url = "#{overlord_url}/analytics"
end

def wait_for_results(requester, url, code = 200)
  total_sleep_time = 0
  loop do
    response = requester.get(url, nil)
    json = response[:json]
    if json.nil?
      return nil
    end
    calculation = json[:calculation]
    if calculation[:isComplete]
      return calculation
    else
      return nil if total_sleep_time > 60 * 5
      sleep_time = calculation[:pollInterval] / 1000.0
      sleep sleep_time
      total_sleep_time += sleep_time
    end
  end
end
