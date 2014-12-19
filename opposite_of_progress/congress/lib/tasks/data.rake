require 'sunlight_api'

desc "Requests Legislator data"
task data: [:environment, :pull_bill_data, :pull_legislator_data]

desc "Pull in Legislator data"
task :pull_legislator_data do
  SunlightAPI.request_data('Legislator', 'bioguide_id')
end

desc "Pull in Bills"
task :pull_bill_data do
  SunlightAPI.request_data('Bill')
end
