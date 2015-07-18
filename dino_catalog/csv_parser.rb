require_relative('dinosaur.rb')

class DinodexParserCSV
  def initialize(filepath)
    parse(filepath)
  end

  def parse(filepath)
    @file = open(filepath, 'r')
    generate_categories
    generate_data
    @dinosaurs
  end

  def generate_categories
    @categories = clean_row(@file.first)
    convert_african
  end

  def generate_data
    @dinosaurs = []
    @file.each do |row|
      row_data = Hash[@categories.zip(clean_row(row))]
      @dinosaurs << Dinosaur.new(row_data)
    end
  end

  def clean_row(row)
    line = row.split(',')
    line.each do |value|
      value.strip!
      value.capitalize!
    end
    line
  end

  def convert_african
    convert('Genus', 'Name')
    convert('Carnivore', 'Diet')
    convert('Weight', 'Weight_in_lbs')
  end

  def convert(from, to)
    index = @categories.index(from)
    unless index.nil?
      @categories[index] = to
    end
  end

end

dex = DinodexParserCSV.new('dinodex.csv')
list = dex.parse('african_dinosaur_export.csv')
list.each do |dino|
  puts dino
end