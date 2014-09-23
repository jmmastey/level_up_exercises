require_relative "affricandinomapper"
require_relative "favoritedinomapper"
require_relative "dino"
require "csv"
require "json"

class DinoDex
  DINO_MAPPERS = [FavoriteDinoMapper.new, AfricanDinoMapper.new]
  include Enumerable

  def initialize(dinos = [], filter = {})
    @dinos = dinos
    @filter = filter
  end

  def add_data(*file_paths)
    file_paths.each do |file_path|
      parse_file file_path
    end
  end

  def filter(criteria = {})
    result_data = @dinos.select do |dino|
      meets_criteria(criteria, dino)
    end
    self.class.new(result_data, @filter.merge(criteria))
  end

  def to_s
    <<-STRING
###############
Dino Dex Entries (Count: #{@dinos.length})
---------------
Filter:
#{@filter.map { |f, v| "#{f}: #{v}" }.join("\n")}
---------------
#{@dinos.map { |dino| "#{dino}" }.join("\n")}
###############
    STRING
  end

  def to_json
    @dinos.to_json
  end

  def method_missing(method, *args)
    if /having_/ =~ method
      criteria = args.length > 1 ? args : args[0]
      field = method[7..-1].to_sym
      filter(field => criteria)
    else
      super
    end
  end

  def each(&block)
    @dinos.each(&block)
  end

  private

  def parse_file(file_path)
    csv = CSV.open(file_path, headers: true)
    mapper = get_mapper(csv)
    @dinos.concat csv.map { |row| create_dino(mapper.map(row.to_hash)) }
  end

  def get_mapper(csv_file)
    first_line = csv_file.first.to_hash
    mapper = DINO_MAPPERS.find { |m| m.can_map? first_line }
    raise "Can't find a mapper for file #{file_path}" unless mapper
    csv_file.rewind
    mapper
  end

  def meets_criteria(criteria, dino)
    criteria.all? do |field, value|
      raise "Invalid search criteria #{field}" unless dino.respond_to?(field)
      raise "Already filtering on #{field}" if @filter.key?(field)
      match(dino.send(field), value)
    end
  end

  def match(left, right)
    if right.is_a? Array
      left.send(right[0], right[1])
    elsif right.is_a? String
      /#{right}/ =~ left
    else
      left == right
    end
  end

  def create_dino(data)
    Dino.new(data[:name], data)
  end
end
