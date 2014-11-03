task :deeds => :environment do
  puts "Bills last voted on"
  Deed::law_voted_on

  puts "Bills enacted into law"
  Deed::enacted_into_law
  
  puts "Deeds complete"
end