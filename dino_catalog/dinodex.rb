require 'json'
require 'set'
require './dino.rb'

class Dinodex
  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos || []
  end

  def index
    @dinos.each { |dino| puts "#{dino}\n" }
  end

  def less_than(field, value)
    match = @dinos.select do |dino| 
      dino.less_than?(field, value) 
    end
    
    Dinodex.new(match)
  end

  def greater_than(field, value)
    match = @dinos.select do |dino| 
      dino.greater_than?(field, value) 
    end
    
    Dinodex.new(match)
  end

  def equal(field, value)
    match = @dinos.select do |dino| 
      dino.equal?(field, value) 
    end
    
    Dinodex.new(match)
  end

  def not_equal(field, value)
    match = @dinos.select do |dino| 
      dino.not_equal?(field, value) 
    end
    
    Dinodex.new(match)
  end

  def less_or_equal(field, value)
    match = @dinos.select do |dino| 
      dino.less_or_equal?(field, value) 
    end
    
    Dinodex.new(match)
  end

  def greater_or_equal(field, value)
    match = @dinos.select do |dino| 
      dino.greater_or_equal?(field, value) 
    end

    Dinodex.new(match)
  end

  def like(field, value)
    match = @dinos.select do |dino| 
      dino.like?(field, value) 
    end
    
    Dinodex.new(match)
  end

  def not_like(field, value)
    match = @dinos.select do |dino| 
      dino.not_like?(field, value) 
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
      a.compare(field, b.send(field))
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
