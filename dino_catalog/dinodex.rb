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
    Dinodex.new(_lt(field, value))
  end

  def greater_than(field, value)
    Dinodex.new(_gt(field, value))
  end

  def equal(field, value)
    Dinodex.new(_eq(field, value))
  end

  def not_equal(field, value)
    Dinodex.new(@dinos - _eq(field, value))
  end

  def less_or_equal(field, value)
    Dinodex.new(
      _lt(field, value) + _eq(field, value),
    )
  end

  def greater_or_equal(field, value)
    Dinodex.new(
      _gt(field, value) + _eq(field, value),
    )
  end

  def like(field, value)
    Dinodex.new(_like(field, value))
  end

  def not_like(field, value)
    Dinodex.new(@dinos - _like(field, value))
  end

  def search(hash)
    hash.inject(self) do |ddex, pair|
      ddex.equal(pair[0], pair[1])
    end
  end

  def sort(field)
    Dinodex.new(
      @dinos.sort do |a, b|
        a.compare(field, b.attrs[field])
      end,
    )
  end

  def json
    {
      'dinos' => @dinos.map(&:attrs),
    }.to_json
  end

  def inspect
    dinos.inspect
  end

  private

  def _lt(field, value)
    @dinos.select { |dino| dino.less_than?(field, value) }
  end

  def _gt(field, value)
    @dinos.select { |dino| dino.greater_than?(field, value) }
  end

  def _eq(field, value)
    @dinos.select { |dino| dino.equal?(field, value) }
  end

  def _like(field, value)
    @dinos.select { |dino| dino.like?(field, value) }
  end
end
