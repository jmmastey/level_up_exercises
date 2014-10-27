task :deeds => :environment do
  puts "Bills last voted on"
  Deed.new.law_voted_on
  
  puts "Deeds complete"
end