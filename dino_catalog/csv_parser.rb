require_relative('dinosaur.rb')
require_relative('dinodex.rb')

class DinodexParserCSV
  def parse(filepath)
    @path = filepath
    @file = open(@path, 'r')
    generate_categories
    generate_data
  end

  def generate_categories
    @categories = clean_row(@file.first)
    convert_african if african_csv?
  end

  def generate_data
    @dinosaurs = @file.map { |row| generate_dinosaur(row) }
  end

  def clean_row(row)
    line = row.split(',')
    line.each do |value|
      value.strip!
      value.capitalize!
    end
  end

  def generate_dinosaur(row)
    dino_hash = Hash[@categories.zip(clean_row(row))]
    convert_african_hash(dino_hash) if african_csv?
    Dinosaur.new(dino_hash)
  end

  def african_csv?
    @path == 'african_dinosaur_export.csv'
  end

  def convert_african
    convert('Genus', 'Name')
    convert('Weight', 'Weight_in_lbs')
  end

  def convert_african_hash(map)
    map['Continent'] = 'Africa'
    if map['Carnivore'] == 'Yes'
      map['Diet'] = 'Carnivore'
    else
      map['Diet'] = 'Not Specified'
    end
  end

  def convert(from, to)
    index = @categories.index(from)
    @categories[index] = to unless index.nil?
  end
end
