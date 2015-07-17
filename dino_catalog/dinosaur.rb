require_relative 'dino_parser'

class Dinodex
  SEARCH_NAME = lambda do |res, name|
    res.select { |dino| dino.name_is(name) }
  end

  SEARCH_PERIOD = lambda do |res, period|
    res.select { |dino| dino.from_period(period) }
  end

  SEARCH_DISPATCHER = {
    "name" => SEARCH_NAME,
    "period" => SEARCH_PERIOD,
  }

  attr_accessor :registry

  def initialize
    @registry = []
  end

  def search(args, results=@registry)
    return results unless args.length > 0
    k, v = args.pop
    results = SEARCH_DISPATCHER[k].call(results, v)
    search(args, results)
  end

  def to_s(subset=@registry)
    max_col_len = subset.
  end

  def load_data(data)
    data.each do |row|
      @registry << Dinosaur.new(row)
    end
  end

  def load_csv(filename)
    return false unless File.file?(filename)
    data = DinoTranslator.translate(DinoParser.parse_csv(filename))
    load_data(data) if DinoValidator.valid_data?(data)
  end
end

class Dinosaur
  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def has?(key)
    @data.include?(key)
  end

  def name_is(name)
    @data['name'] == name if has?('name')
  end

  def from_period(period)
    @data['period'].include?(period) if has?('period')
  end

  def to_s
    max_len = @data.keys.max_by { |k| k.length if @data[k].length > 0 }.length
    @data.each do |k, v|
      spaces = ' ' * (max_len - k.length) + ' '
      puts k + ':' + spaces + v if v.length > 0
    end
  end
end

def main
  dinodex = Dinodex.new
  dinodex.load_csv('dinodex.csv')

  args = [
    %w(period cretaceous),
  ]
  dinodex.search(args)
end

# dinodex = Dinodex.new
# ARGV.each do |arg|
#   dinodex.load_csv(arg)
# end
