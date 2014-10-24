task :cron => :environment do
  puts "Pull in Legislators"
  Legislator.new.fetch

  puts "Pull in Bills"
  Bill.new.fetch

  puts "Crons complete"
end