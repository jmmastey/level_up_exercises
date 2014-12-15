class DinosaurInfo
  attr_accessor :dinosaurs, :dinosaurs_filtered,:filters

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  # options should be in the following format
  # { operator <string> => { attribute: value } }
  def filter_dinosaurs(options={})
    @dinosaurs_filtered = @dinosaurs
    @filters = options
    options.each do |operator, filters|
      filters.each do |key, value|
        @dinosaurs_filtered = @dinosaurs_filtered.select { |dinosaur| dinosaur.send("#{key}").send(operator,value) }
      end
    end
    @dinosaurs_filtered
  end

  def print_dinosaurs_info(include_filter=false)
      if include_filter
        dinosaurs = @dinosaurs_filtered
        title = "DinoDex current Dinosaur Info Last Filter (#{@filters}):"
      else
        dinosaurs = @dinosaurs
        title = "DinoDex current Dinosaur Info:"
      end
      puts title
      puts "----------------------"
      dinosaurs.each do |dinosaur|
        dinosaur.print_dinosaur_info
        puts "----------------------"
      end
  end

  def json_export(include_filter=false)
    if include_filter
      dinosaurs = @dinosaurs_filtered
    else
      dinosaurs = @dinosaurs
    end
    dinosaurs.to_json
  end

end

# csv_files = ['/Users/jfinzel/level_up_exercises/dino_catalog/dinodex.csv',
#             '/Users/jfinzel/level_up_exercises/dino_catalog/african_dinosaur_export.csv']
#
# dino_import = DinosaurImport.new(csv_files)
# dino_info = DinosaurInfo.new(dino_import.dinosaurs)
# #dino_info.dinosaurs.each { |dinosaur| puts "#{dinosaur.inspect}" }
#
# # All Biped
# options = { "==" => {walking: 'Biped'}}
# puts 'BIPEDS:'
# dino_info.dinosaurs_filtered(options).each { |dinosaur| puts "#{dinosaur.inspect}, @is_carnivore=#{dinosaur.is_carnivore}" }
#
# # All Carnivores, Insectivores, Piscivore'
# options = { "==" => {is_carnivore: true}}
# puts 'CARNIVORES'
# dino_info.dinosaurs_filtered(options).each { |dinosaur| puts "#{dinosaur.inspect}" }
#
# # By Period
# options = { "==" => {period: 'Cretaceous'} }
# puts 'PERIOD'
# dino_info.dinosaurs_filtered(options).each { |dinosaur| puts "#{dinosaur.inspect}" }
#
# #Big and small
# options = { ">" => { weight_in_lbs: 4000 } }
# puts 'BIG'
# dino_info.dinosaurs_filtered(options).each { |dinosaur| puts "#{dinosaur.inspect}, @period_type=#{dinosaur.period_type}" }
#
# #Print individual dino info
# dino_info.print_dinosaurs_info
# dino_info.print_dinosaurs_info(true)
# puts dino_info.json_export