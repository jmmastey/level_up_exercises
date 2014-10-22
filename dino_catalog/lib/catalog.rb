require 'CSV'
require_relative 'dinosaur'
require_relative 'csv_modifier'

class Catalog

  # Initialize the new catalog

  def initialize(path=nil, name)
    @path = path
    @catalog_name = name
    @catalog = []
    build_catalog_entries(@path, @catalog_name)
    @catalog.each { |entry| puts entry.inspect }
  end

  def build_catalog_entries(filepath, catalog_name)
    CsvModifier.normalize_csv_headers(filepath, catalog_name)
    normalized_filepath_name = CsvModifier.normalized_filepath(catalog_name)
    #CsvModifier.replace_cell_with_carnivore(normalized_filepath_name)
    CSV.read(normalized_filepath_name, headers: true, header_converters: :symbol).each do |data|
      @catalog << create_dinosaur_entry(data[:name], data)
    end
  end

  def create_dinosaur_entry(name, attributes)
    Dinosaur.new(name, attributes)
  end

end
