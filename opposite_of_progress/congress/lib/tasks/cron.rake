desc "Pulls in legislator and bills data"
task cron: :environment do
  puts "Pull in Legislators"
  base_url = "#{ApplicationHelper::API_BASE_PATH}legislators?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}"
  (1..20).each do |num|
    data = ApplicationHelper.pull_resource("#{base_url}&page=#{num}")
    ApplicationHelper.fetch('Legislator', data, 'bioguide_id')
  end

  puts "Pull in Bills"
  base_url = "#{ApplicationHelper::API_BASE_PATH}bills?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}"
  (1..20).each do |num|
    data = ApplicationHelper.pull_resource("#{base_url}&page=#{num}")
    ApplicationHelper.fetch('Bill', data)
  end

  puts "Crons complete"
end
