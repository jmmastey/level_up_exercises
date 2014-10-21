require 'CSV'
require_relative 'dinosaur'

class Catalog

  # Initialize the new catalog

  def initialize(path=nil, name)
    @path = path
    @catalog_name = name
    @catalog = []
    build_catalog_entries(path)
  end

  def build_catalog_entries(filepath)
    normalize_csv_headers(filepath)
    normalized_filepath_name = normalized_filepath
    CSV.read(normalized_filepath_name, headers: true, header_converters: :symbol).each do |data|
      @catalog << create_dinosaur_entry(data[:name], data)
    end
  end

  def create_dinosaur_entry(name, attributes)
    Dinosaur.new(name, attributes)
  end

  def normalize_csv_headers(old_csv_file)
    normalized_filepath_name = normalized_filepath
    CSV.open(normalized_filepath_name, 'w') do |csv|
      csv << ['NAME', 'PERIOD', 'CONTINENT', 'DIET', 'WEIGHT_IN_LBS', 'WALKING', 'DESCRIPTION']
      CSV.read(old_csv_file, headers: true).each do |row|
        csv.puts row
      end
    end
  end

  def normalized_filepath
    File.join(APP_ROOT, "normalized_#{@catalog_name}")
  end

end
