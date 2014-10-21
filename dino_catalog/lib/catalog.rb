require 'CSV'
require_relative 'dinosaur'

class Catalog

  # Initialize the new catalog

  def initialize(path=nil, name)
    @path = path
    @name = name
    @catalog = []
    build_catalog_entries(path)
  end

  # load in the csv file

  def build_catalog_entries(filepath)
    CSV.read(filepath, headers: true, header_converters: :symbol).each do |data|
      @catalog << create_dinosaur_entry(data)
    end
    @catalog.each { |entry| puts entry.name }
  end

  def create_dinosaur_entry(attributes)
    Dinosaur.new(attributes)
  end

end
