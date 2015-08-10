require 'csv'
require_relative 'dinosaur'

class Dinodex
  attr_reader :db

  def initialize
    @db = []
  end

  def import(filename)
    db.concat(parse_csv(filename))
  end

  def parse_csv(filename)
    csv = CSV.new(IO.read(filename), headers: true, converters: :all)

    csv.to_a.map { |row| Dinosaur.new(row.to_hash) }
  end

  def filters
    @filter ||= []
  end

  def filter(args)
    args[:op] ||= "=="
    filters.push(args)
    self
  end

  def each(&block)
    db.reject do |dino|
      !match_dino(dino)
    end.each(&block)
  end

  def match_dino(dino)
    match = 1

    filters.each do |filter|
      op = filter[:op]
      key,target = filter.first
      value = dino.method(key).call

      match = match & 0 unless value && value.method(op).(target)
    end

    match == 1
  end
end

dex = Dinodex.new

dex.import("dinodex.csv")
dex.import("african_dinosaur_export.csv")

dex.filter({ weight: 2000, op: ">" }).filter({ carnivore: true }).each do |dino|
  puts dino.to_s
  puts
end
