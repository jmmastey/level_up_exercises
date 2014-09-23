require_relative "affricandinomapper"
require_relative "favoritedinomapper"
require_relative "dino"
require "csv"
require "json"

class DinoDex
  DINO_MAPPERS = [FavoriteDinoMapper.new, AfricanDinoMapper.new]
  include Enumerable

  def initialize(dinos = [], options = {})
    @dinos = dinos
    @filter = options[:filter] || {}
  end

  def add_data(*file_paths)
    file_paths.each do |file_path|
      csv = CSV.open(file_path, headers: true)
      # is there a better way to do this to get the first line and then parse
      mapper = DINO_MAPPERS.detect { |m| m.can_map?(csv.first.to_hash) }
      raise "Can't find a mapper for file #{file_path}" unless mapper
      csv.rewind
      @dinos.concat csv.map { |row| create_dino(mapper.map(row.to_hash)) }
    end
  end

  def filter(criteria = {})
    result_data = @dinos.select do |dino|
      criteria.all? do |field, value|
        raise "Invalid search criteria #{field}" unless dino.respond_to?(field)
        raise "Already filtering on #{field}" if @filter.has_key?(field)
        match(dino.send(field), value)
      end
    end
    self.class.new(result_data, filter: @filter.merge(criteria))
  end

  def to_s
    result = "###############\n" <<
      "Dino Dex Entries (Count: #{@dinos.length})\n" <<
      "---------------\n" <<
      "Filter: \n" <<
      @filter.map { |f, v| "#{f}: #{v}" }.join("\n") << "\n" <<
      "---------------\n" <<
      @dinos.map { |dino| "#{dino}" }.join("\n") << "\n" <<
      "###############\n"
  end

  def to_json
    @dinos.to_json
  end

  def method_missing(method, *args)
    if /having_/ =~ method
      criteria = args.length > 1 ? args : args[0]
      field = method[7..-1].to_sym
      filter({ field => criteria })
    else
      super
    end
  end

  def each(&block)
    @dinos.each(&block)
  end

  private
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

