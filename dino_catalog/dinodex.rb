require_relative "african_dino_mapper"
require_relative "favorite_dino_mapper"
require_relative "dino"
require "csv"
require "json"

class DinoDex
  DINO_MAPPERS = [FavoriteDinoMapper.new, AfricanDinoMapper.new]
  DINO_PROPERTIES = [:continent, :walking, :diet, :carnivore, :description, 
                     :name, :period, :weight]
  include Enumerable

  DINO_PROPERTIES.each do |property|
    define_method("having_#{property}") do |criteria|
      filter(property => criteria)
    end
  end

  def initialize(dinos = [], filter = [])
    @dinos = dinos
    @filter = filter
  end

  def add_data(*file_paths)
    file_paths.each do |file_path|
      parse_file file_path
    end
  end

  def filter(criteria)
    result_data = @dinos.select { |dino| dino.match? criteria }
    self.class.new(result_data, @filter + criteria.to_a)
  end

  def to_json
    @dinos.to_json
  end

  def each(&block)
    @dinos.each(&block)
  end

  def to_s
    <<-STRING
###############
Dino Dex Entries (Count: #{@dinos.length})
---------------
Filter:
#{@filter.map { |f| "#{f.first}: #{f.last}" }.join("\n")}
---------------
#{@dinos.join("\n")}
###############
    STRING
  end

  private

  def parse_file(file_path)
    csv = CSV.open(file_path, headers: true)
    dino_mapper = get_mapper(csv) || raise("Could not map file #{file_path}")
    csv.each { |row| add_dino(dino_mapper.map(row.to_hash)) }
  end

  def get_mapper(csv_file)
    # can't use csv_file.headers here, because I'm using the file as a stream,
    # so the headers are not loaded until at least a line is read. Could read
    # the entire file in initially, but that would not let us opperate on
    # larger files.
    first_line = csv_file.first.to_hash
    csv_file.rewind
    DINO_MAPPERS.detect { |m| m.can_map? first_line }
  end

  def add_dino(data)
    @dinos << Dino.new(data[:name], data)
  end
end
