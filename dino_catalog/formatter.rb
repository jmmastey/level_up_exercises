require 'csv'
load 'dinosaur.rb'

# Class Formatter will format input csv files
class Formatter
  HEADER_CONVERTER =
      {
        'genus' => 'name',
        'weight_in_lbs' => 'weight'
      }

  def self.format(csvfile)
    rows = CSV.read(csvfile,
                    headers: :first_row,
                    header_converters:
                      [:downcase, ->(h) { header_mapper(h) }, :symbol])
    convert_data(rows, csvfile)
    rows.map { |row| Dinosaur.new(row) }
  end

  def self.convert_data(rows, csvfile)
    convert_rows(rows, csvfile)
    convert_weight(rows)
  end

  def self.convert_rows(rows, csvfile)
    rows.each do |row|
      row[:source] = file_name(csvfile)
      row[:continent] = 'Africa' if african_dino?(csvfile)
      if row[:carnivore] == 'Yes'
        row[:diet] = 'Carnivore'
      elsif row[:carnivore] == 'No'
        row[:diet] = 'Herbivore'
      end
    end
  end

  def self.convert_weight(rows)
    rows.each { |row| row[:weight] = row[:weight].to_i }
  end

  def self.african_dino?(csvfile)
    file_name(csvfile) == 'african_dinosaur_export'
  end

  def self.header_mapper(header)
    HEADER_CONVERTER[header] || header
  end

  def self.file_name(csvfile)
    File.basename(csvfile, '.*')
  end
end
