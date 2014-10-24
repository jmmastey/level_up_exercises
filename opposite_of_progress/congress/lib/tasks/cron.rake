task :cron => :environment do
  puts "Pull in Legislators"

  # Legislator.new.fetch
  Bill.new.fetch

  puts "Crons complete"
end