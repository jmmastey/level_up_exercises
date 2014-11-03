task :cron => :environment do
  puts "Pull in Legislators"
  base_url = "#{ApplicationHelper::API_BASE_PATH}legislators?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}"
  Legislator.new.fetch("#{base_url}&page=1")
  Legislator.new.fetch("#{base_url}&page=2")
  Legislator.new.fetch("#{base_url}&page=3")
  Legislator.new.fetch("#{base_url}&page=4")
  Legislator.new.fetch("#{base_url}&page=5")
  Legislator.new.fetch("#{base_url}&page=6")
  Legislator.new.fetch("#{base_url}&page=7")
  Legislator.new.fetch("#{base_url}&page=8")
  Legislator.new.fetch("#{base_url}&page=9")

  puts "Pull in Bills"
  base_url = "#{ApplicationHelper::API_BASE_PATH}bills?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}"
  Bill.new.fetch("#{base_url}&page=1")
  Bill.new.fetch("#{base_url}&page=2")
  Bill.new.fetch("#{base_url}&page=3")
  Bill.new.fetch("#{base_url}&page=4")
  Bill.new.fetch("#{base_url}&page=5")
  Bill.new.fetch("#{base_url}&page=6")
  Bill.new.fetch("#{base_url}&page=7")
  Bill.new.fetch("#{base_url}&page=9")
  Bill.new.fetch("#{base_url}&page=8")

  puts "Crons complete"
end