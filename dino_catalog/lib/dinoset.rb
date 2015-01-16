require 'json'

class DinoSet
  include Enumerable

  alias_method :to_ary, :to_a

  def initialize(dinos)
    @dinos = dinos
  end

  def each(&block)
    @dinos.each(&block)
  end

  def pluck(&block)
    self.class.new(select(&block))
  end

  def pluck!(&block)
    @dinos = pluck(&block).entries
  end

  def search(args)
    args.each_with_object(self.dup) do |(key, value), results|
      key = key.to_s.downcase
      value.downcase! if value.respond_to?(:downcase!)

      results.pluck! do |dino|
        result = dino.send(key)
        result.downcase! if result.respond_to?(:downcase!)
        result == value
      end
    end
  end

  def bipeds
    pluck(&:biped)
  end

  def carnivores
    pluck(&:carnivore)
  end

  def big
    pluck(&:big)
  end

  def small
    pluck(&:small)
  end

  def in_period(period)
    pluck { |dino| dino.period =~ /#{period}/i }
  end

  def to_json
    to_a.to_json
  end
end
