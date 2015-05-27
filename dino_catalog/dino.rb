$LOAD_PATH << '.'
require 'dinosaur_catalog'

CATALOG_DIR = 'catalogs/'
@dinosaurs = []

def load_file(filename)
  File.open(CATALOG_DIR + filename).each_with_index do |line, index|
    next if index == 0
    dinosaur = Dinosaur.new(line, filename)
    @dinosaurs.push(dinosaur)
  end
end


# MAIN
Dir.foreach(CATALOG_DIR) do |item|
  next if item == '.' || item == '..' || item == '.DS_Store'
  load_file(item)
end

dinosaur_catalog = Dinosaur_Catalog.new(@dinosaurs)


puts "Welcome to your Poke... erhm, I mean DinoDex"
puts "I will allow you to filter all of your known dinosaurs by certain criteria"
puts "Your Available search parameters are:"
puts "\tbipeds: Returns all dinosaurs that are bipeds"
puts "\tcarnivores: Returns all dinosaurs that are carnivores"
puts "\tXXX period: Where XXX is your period search criteria, Returns all dinosaurs that were alive in that period"
puts "\tbig: Returns all dinosaurs with a weight over 2 tons"
puts "\tsmall: Returns all dinosaurs with a weight 2 tons || under"
puts "\tfilter XXX: where XXX is a ruby hash containing filters defined above"
puts "\tfacts: Displays all known information about each dinosaur matching your current search criteria"
puts "\tprint: Displays only the names of each dinosaur matching your current search criteria"
puts "\tclear: resets all search parameters."
puts ""
puts "Example 1: This will print the names of all small bipeds that you know about"
puts "\tbipeds"
puts "\tsmall"
puts "\tprint"
puts "Example 2: This will print all of the facts you know about small bipeds."
puts "\tbipeds.small.facts"
puts "Example 3: This will return a all of the facts you know about bipeds, that are carnivores, from the Jurrasic period that are over 2 tons"
puts "\tfilter {bipeds: true, carnivores: true, period: \"Jurassic\", big: true}.facts"
puts "\tThis would be the same as doing: bipeds.carnivores.period Jurassic.big.facts"
puts ""
puts ""


while true
  print "DinoDex:" 
  gets_ary = gets.chomp.split('.')
  gets_ary.each do |item|
    if item == "clear"
      dinosaur_catalog = Dinosaur_Catalog.new(@dinosaurs)
    elsif item.include? "period" 
      dinosaur_catalog = dinosaur_catalog.period(item.gsub("period","").chomp)
    elsif item.include? "filter" 
      dinosaur_catalog = dinosaur_catalog.filter(eval(item.gsub("filter","").chomp))
    elsif item == "exit"
      abort
    else
      dinosaur_catalog = dinosaur_catalog.send(item)
    end
  end
end

  
#{bipeds: true, carnivores: true, big: true}
#{period: "Jurrasic"}

#dinosaur_catalog.filter({bipeds: true}).facts
#dinosaur_catalog.filter({bipeds: true, carnivores: true, big: true}).facts
#dinosaur_catalog.filter({bipeds: true, carnivores: true, big: "face"}).facts
#dinosaur_catalog.filter({bipeds: true, carnivores: true, period: "Jurassic", big: true}).facts

