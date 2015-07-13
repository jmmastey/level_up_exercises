#!/usr/bin/ruby

require_relative 'dino_loader'
require_relative 'dinosaur'
require_relative 'dino_catalog'
require_relative 'dino_loader'

catalog = DinoCatalog.new
catalog.populate_data

puts "*\n*\n*\n"
puts '************ SEARCH BY NAME **************'
puts catalog.search_by_trait('name', 'Albertonykus')

puts "*\n*\n*\n"
puts '************ Herbivores *************'
puts catalog.search_by_trait('diet', 'Herbivore')

puts "*\n*\n*\n"
puts '************ Bipeds *************'
puts catalog.search_by_trait('walking', 'biped')

puts "*\n*\n*\n"
puts '************ Herbivores *************'
puts catalog.search_by_trait('diet', 'Herbivore')

puts "*\n*\n*\n"
puts '************ South America **************'
puts catalog.search_by_trait('continent', 'South America')

puts "*\n*\n*\n"
puts '************ Cretaceous/Herbivores **************'
puts catalog.search_by_trait('period', 'Cretaceous')
  .search_by_trait('diet', 'Herbivore'
                  )

puts "*\n*\n*\n"
puts '************ Herbivores **************'
puts catalog.search_by_trait('diet', 'Herbivore')

puts "*\n*\n*\n"
puts '************ AFRICA **************'
puts catalog.search_by_trait('continent', 'Africa')

puts "*\n*\n*\n"
puts '************ BIG **************'
puts catalog.search_by_size('big')

puts "*\n*\n*\n"
puts '************ ALL DATA **************'
puts catalog.show_data
