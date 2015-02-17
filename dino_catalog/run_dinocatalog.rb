load 'dinodex.rb'

puts ''
puts 'To search dinasours write your query like :'
puts '    search dinos where name = Albertosaurus and weight = small'
puts ''
puts 'To use hash search write query like :'
puts '    {name = Albertosaurus , weight = small}'
puts ''
query = gets.chomp
puts ''
puts '    what output you want json or table, default is table'
puts ''
format = gets.chomp
puts ''

dino = DinoCatalog.new('dinodex.csv', 'african_dinosaur_export.csv')
dino.search(query, format)
