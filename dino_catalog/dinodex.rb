require_relative 'CSVParse'

class Dinodex
  attr_reader :dinosaurs

  def initialize(files = nil, dinosaurs = nil)
    @dinosaurs = dinosaurs unless dinosaurs.nil?
    parse_all_files(files) unless files.nil?
  end

  def parse_all_files(files)
    parser = CSVParse.new
    files.each do |file|
      @dinosaurs = parser.parse_csv(file) if File.exist?(file) \
                && file.split(//).last(3).join.casecmp('csv')
    end
  end

  def print_all_dinos
    @dinosaurs.each do |dino|
      dino.all_variables.each { |attri| puts attri }
      puts "\n----------\n\n"
    end
  end

  def bipeds
    tmp_dino = Dinodex.new(nil, dinosaurs.dup)
    tmp_dino.dinosaurs.keep_if do |dino|
      dino.walking == 'Biped'
    end
    tmp_dino
  end

  def carnivores
    tmp_dino = Dinodex.new(nil, dinosaurs.dup)
    tmp_dino.dinosaurs.select { |dino| dino.carnivore == "Yes" }
    tmp_dino
  end

  def period(p)
    tmp_dino = Dinodex.new(nil, dinosaurs.dup)
    tmp_dino.dinosaurs.keep_if do |dino|
      dino.period.downcase.include? p.downcase
    end
    tmp_dino
  end
end

puts Dinodex.new(parse_csv(['dinodex.csv'])).bipeds.carnivore.period('Jurassic').dinosaurs
