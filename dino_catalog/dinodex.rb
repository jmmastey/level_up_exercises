require_relative "dinoparser"
require_relative "dino"
require "csv"
require "json"

class DinoDex
  PARSER_MAP = [FavoriteDinoParser, AfricanDinoParser]
  include Enumerable

  def initialize(dinos = [], options = {})
    @dinos = dinos
    @filter = options[:filter] || {}
  end

  def add_data(*file_paths)
    file_paths.each do |file_path|
      parser = nil
      CSV.foreach(file_path, :headers => true) do |row|
        item = row.to_hash
        parser ||= PARSER_MAP.find { |pmap| pmap.can_parse?(item) }
        @dinos << parser.parse(item)
      end
    end
  end

  def filter(criteria = {})
    result_data = @dinos.find_all do |dino|
      criteria.all? do |field, value|
        raise "Invalid search criteria #{field}" unless dino.respond_to? field
        if value.is_a? Array
          v = dino.send(field)
          v = v.to_f if value[1].is_a? Numeric
          v.send(value[0], value[1])
        elsif value.is_a? String
          /#{value}/.match(dino.send(field))
        else
          dino.send(field) == value
        end
      end
    end
    self.class.new(result_data, filter: @filter.merge(criteria))
  end

  def to_s
    result = "###############\n"
    result << "Dino Dex Entries (Count: #{@dinos.length})\n"
    result << "---------------\n"
    result << "Filter: \n" unless @filter.empty?
    @filter.each { |f, v| result << "#{f}: #{v}\n" }
    result << "---------------\n"
    @dinos.each { |dino| result << "#{dino}\n" }
    result << "###############\n"
  end

  def to_json
    @dinos.map { |dino| dino.to_hash}.to_json
  end

  def method_missing(method, *args)
    if /having_/.match(method)
      criteria = args.length > 1 ? args : args[0]
      field = method[7..-1].to_sym
      filter({field => criteria})
    else
      super
    end
  end

  def each(&block)
    @dinos.each(&block)
  end
end
