task :cron => :environment do
  puts "Pull in Legislators"
  base_url = "#{ApplicationHelper::API_BASE_PATH}legislators?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}"
  [1..10].each do |num|
    Legislator.new.fetch("#{base_url}&page=#{num}")
  end

  puts "Pull in Bills"
  base_url = "#{ApplicationHelper::API_BASE_PATH}bills?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}"
  [1..10].each do |num|
    Bill.new.fetch("#{base_url}&page=#{num}")
  end

  puts "Crons complete"
end