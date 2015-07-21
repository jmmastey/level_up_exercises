require 'json'
require './dino.rb'
require './dino_compare.rb'

class Dinodex
  OPERATIONS = %w(less_than greater_than equal not_equal)
  OPERATIONS += %w(less_or_equal greater_or_equal like not_like)

  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos || []
  end

  def index
    @dinos.each { |dino| puts "#{dino}\n" }
  end

  def method_missing(name, *args, &block) 
    return unless OPERATIONS.include?(name.to_s)
    return unless args.count == 2

    match = @dinos.select do |dino|
      new_args = [dino.send(args[0]), args[1]]
      DinoCompare.send("#{name}?", *new_args)
    end
    Dinodex.new(match)
  end

  def search(hash)
    hash.inject(self) do |ddex, pair|
      ddex.equal(pair[0], pair[1])
    end
  end

  def sort(field)
    sorted = @dinos.sort do |a, b|
      DinoCompare.compare(a, field, b.send(field))
    end
    Dinodex.new(sorted)
  end

  def to_json
    {
      'dinos' => @dinos.map(&:properties)
    }.to_json
  end

  def inspect
    dinos.inspect
  end
end
