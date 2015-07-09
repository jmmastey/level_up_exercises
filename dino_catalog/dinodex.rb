require 'json'
require 'set'
require './dino.rb'

class Dinodex
  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos || []
  end

  def index
    @dinos.each(&:dino_facts)
  end

  def less_than(field, value)
    Dinodex.new(lt(field, value))
  end

  def greater_than(field, value)
    slt = select_less_than(field, value)
    seq = select_equal(field, value)
    Dinodex.new(@dinos - slt - seq)
  end

  def equal(field, value)
    Dinodex.new(select_equal(field, value))
  end

  def not_equal(field, value)
    Dinodex.new(@dinos - select_equal(field, value))
  end

  def less_or_equal(field, value)
    slt = select_less_than(field, value)
    seq = select_equal(field, value)
    Dinodex.new(slt + seq)
  end

  def greater_or_equal(field, value)
    slt = select_less_than(field, value)
    Dinodex.new(@dinos - slt)
  end

  def like(field, value)
    Dinodex.new(select_like(field, value))
  end

  def not_like(field, value)
    Dinodex.new(@dinos - select_like(field, value))
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
      'dinos' => @dinos.map { |dino| Hash[dino.properties] }
    }.to_json
  end

  def inspect
    dinos.inspect
  end

  private

  def select_less_than(field, value)
    @dinos.select { |dino| dino.less_than?(field, value) }
  end

  def select_equal(field, value)
    @dinos.select { |dino| dino.equal?(field, value) }
  end

  def select_like(field, value)
    @dinos.select { |dino| dino.like?(field, value) }
  end
end
