require 'csv'
require 'json'
require_relative 'csv_helper'
require_relative 'dinosaur'

class DinoCatalog
  attr_accessor :data

  def initialize(data = nil)
    @data = data || load_data
  end

  def load_data
    dinodex = CSVHelper.load_csv("dinodex.csv")
    african = CSVHelper.load_csv("african_dinosaur_export.csv")
    merge_data(dinodex, african)
  end

  def dino_filter(&block)
    DinoCatalog.new(@data.select(&block))
  end

  def length
    @data.length
  end

  def print
    JSON.pretty_generate(@data)
  end

  def bipeds
    search(walking: "Biped")
  end

  def carnivores
    search(carnivore: true)
  end

  def period(period)
    dino_filter { |item| item[:period].include? period }
  end

  def heavier_than(weight)
    dino_filter { |item| (item[:weight] || 0) > weight }
  end

  def search(filters)
    data = self
    filters.each do |key, value|
      data = data.dino_filter { |item| item[key] == value }
    end
    data
  end

  def merge_data(dinodex, african)
    dinodex.map { |entry| Dinosaur.normalize_dinodex(entry) } +
      african.map { |entry| Dinosaur.normalize_african(entry) }
  end
end

catalog = DinoCatalog.new
puts "# get carnivores: #{catalog.carnivores.length}"
puts "# bipeds: #{catalog.bipeds.length}"
puts "# Jurassic: " \
  "#{catalog.period('Jurassic').heavier_than(2000).length}"
puts "# Cretaceous: #{catalog.period('Cretaceous').length}"
puts "# really heavy: #{catalog.heavier_than(2000).length}"
puts "# really heavy carnivores: " \
  "#{catalog.heavier_than(2000).carnivores.length}"
puts "JSON: #{catalog.heavier_than(2000).carnivores.data.to_json}"
puts "print: #{catalog.heavier_than(2000).carnivores.print}"
