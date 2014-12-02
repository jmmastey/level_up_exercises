require 'sunlight_api'

desc "Requests Legislator and Bill data"
task cron: :environment do
  puts "Pull in Legislators"
  SunlightAPI.request_data('Legislator', 'bioguide_id')
  
  puts "Pull in Bills"
  SunlightAPI.request_data('Bill')

  puts "API requests complete"
end
