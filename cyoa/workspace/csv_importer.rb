require 'csv'
require './photo.rb'

class CsvImporter
  FILENAME = './photos.csv'
  def initialize
    @raw_photos = import_csv_file(FILENAME)
    #p @raw_photos
  end

  def import_csv_file(filename)
    csv = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      csv << row
    end
    csv
  end

  def create_photos
    @raw_photos.map do |row|
      Photo.new(row)
    end
  end
end

p CsvImporter.new.create_photos