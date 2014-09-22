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
      csv = CSV.open(file_path, headers: true)
      # is there a better way to do this to get the first line and then parse
      parser = PARSER_MAP.detect { |p| p.can_parse?(csv.first.to_hash) }
      raise "Can't parse file #{file_path}" unless parser
      csv.rewind
      @dinos.concat csv.map { |row| parser.parse(row.to_hash) }
    end
  end

  def filter(criteria = {})
    result_data = @dinos.select do |dino|
      criteria.all? do |field, value|
        raise "Invalid search criteria #{field}" unless dino.respond_to?(field)
        # can't have an and filter on the same fields
        raise "Already filtering on #{field}" if @filter.has_key?(field)
        match(dino.send(field), value)
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
end

