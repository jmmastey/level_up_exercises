require 'csv'
require 'json'
require_relative 'dinosaur'

class Dinodex
  def each(&block)
    to_a.each(&block)
  end

  def filter(args)
    args[:op] ||= "=="
    args[:negate] ||= false
    filters.push(args)
    self
  end

  def import(filename)
    @dinos.concat(parse_csv(filename))
  end

  def initialize
    @dinos = []
  end

  def to_a
    arr = @dinos.select { |dino| match?(dino) }
    reset_filters
    arr
  end

  def to_hash
    to_a.map(&:to_hash)
  end

  def to_json
    JSON.pretty_generate(to_hash)
  end

  def to_s
    to_a.map { |dino| "#{dino}\n\n" }.join
  end

  private

  def filters
    @filter ||= []
  end

  def match?(dino)
    filters.all? do |filter|
      key = filter.keys.first
      value = dino.method(key).call
      match_filter?(value, filter)
    end
  end

  def match_filter?(value, filter)
    op = filter[:op]
    negate = filter[:negate]
    target = filter.values.first
    result = !value.nil? && value.method(op).call(target)
    (result && !negate) || (!result && negate)
  end

  def parse_csv(filename)
    csv = CSV.read(filename, headers: true, converters: :all)
    csv.map { |row| Dinosaur.new(row) }
  end

  def reset_filters
    @filter = []
  end
end
