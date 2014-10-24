task :cron => :environment do
  puts "Pull in Legislators"
  
  Legislator.fetch

  puts "Crons complete"
end