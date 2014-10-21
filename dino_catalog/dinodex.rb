require_relative 'CSVParse'

class Dinodex
  attr_reader :dinosaurs

  def initialize(file)
    parser = CSVParse.new
    @dinosaurs = parser.parse_csv(file) if File.exist?(file) \
              && file.split(//).last(3).join.casecmp('csv')
  end

  def print_all_dinos
    @dinosaurs.each do |dino|
      dino.all_variables.each { |attri| puts attri}
      puts "\n----------\n\n"
    end
  end
end
