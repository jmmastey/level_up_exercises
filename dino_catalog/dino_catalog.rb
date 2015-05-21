require 'csv'
require_relative 'dino'
class DinoCatalog

  attr_accessor :catalog

  def initialize(csv_filename=nil)
    self.catalog ||=[]
    if csv_filename
      load(csv_filename)
    end
  end

  def load(csv_filename)
    @catalog_source_file = csv_filename

    dino_csv = CSV.open(csv_filename)
    headers = dino_csv.readline

    dino_csv.readlines.each do |row|
       new_dino = Dino.new(attributes:headers,details:row)
       @catalog << new_dino
      #  puts new_dino.inspect
      #  puts row
    end

  end

  def dino_count
    self.catalog.size
  end

end

# TODO:
#   - Read CSV
#   - Initialize dino catalog
#   - Write specific methods to fetch dinosaurs by filter
