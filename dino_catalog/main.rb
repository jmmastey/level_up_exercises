$LOAD_PATH << '.'

require 'dinosaur_import'
require 'dinosaur_info'

class Main
  csv_files =
      ['/Users/jfinzel/level_up_exercises/dino_catalog/dinodex.csv',
       '/Users/jfinzel/level_up_exercises/dino_catalog/african_dinosaur_export.csv']

  dino_import = DinosaurImport.new(csv_files)
  dino_info = DinosaurInfo.new(dino_import.dinosaurs)

  # All Biped
  attributes = { "==" => { walking: 'Biped' } }
  puts 'BIPEDS:'

  dino_info.filter_dinosaurs(attributes)
  dino_info.dinosaurs_filtered.each do |dinosaur|
    puts "#{dinosaur.inspect}, @carnivore?=#{dinosaur.carnivore?}"
  end

  # All Carnivores, Insectivores, Piscivore'
  dino_info.filter_dinosaurs("==" => { carnivore?: true })
  puts 'CARNIVORES'
  dino_info.dinosaurs_filtered.each { |dinosaur| puts "#{dinosaur.inspect}" }

  # By Period
  dino_info.filter_dinosaurs("==" => { period: 'Cretaceous' })
  puts 'PERIOD'
  dino_info.dinosaurs_filtered.each { |dinosaur| puts "#{dinosaur.inspect}" }

  # Big and small
  dino_info.filter_dinosaurs(">" => { weight: 4000 })
  puts 'BIG'
  dino_info.dinosaurs_filtered.each do |dinosaur|
    puts "#{dinosaur.inspect}, @period_type=#{dinosaur.period_type}"
  end

  # Print individual dino info
  puts dino_info.to_s
  puts dino_info.to_s(true)
  puts dino_info.to_json
end
