require 'csv'
require 'json'
require_relative 'dinosaur'

class Dinodex
  attr_reader :db

  def each(&block)
    to_a.each(&block)
  end

  def filters
    @filter ||= []
  end

  def filter(args)
    args[:op] ||= "=="
    args[:negate] ||= false
    filters.push(args)
    self
  end

  def import(filename)
    db.concat(parse_csv(filename))
  end

  def initialize
    @db = []
  end

  def match_dino(dino)
    match = 1

    filters.each do |filter|
      key = filter.first.first
      value = dino.method(key).call

      match = test_match(match, value, filter)
    end

    match == 1
  end

  def parse_csv(filename)
    csv = CSV.new(IO.read(filename), headers: true, converters: :all)

    csv.to_a.map { |row| Dinosaur.new(row.to_hash) }
  end

  def reset_filters
    @filter = []
  end

  def test_match(match, value, filter)
    op = filter[:op]
    negate = filter[:negate]
    target = filter.first.last

    match &= 0 unless value && (
                 (!negate && value.method(op).call(target)) ||
                 (negate && !value.method(op).call(target)))
    match
  end

  def to_a
    arr = db.reject do |dino|
      !match_dino(dino)
    end

    reset_filters

    arr
  end

  def to_hash
    to_a.map(&:to_hash)
  end

  def to_json
    JSON.generate(to_hash)
  end
end
