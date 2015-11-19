require 'csv'
require 'json'
require_relative 'dinosaur.rb'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

class Dinodex
  attr_reader :master_dinosaur_list

  def initialize(master_dinosaur_list)
    @master_dinosaur_list ||= []
    @master_dinosaur_list = master_dinosaur_list || []
  end

  def csv_header_converters
    {
      headers: true,
      header_converters: :symbol,
      converters: [:all, :blank_to_nil],
    }
  end

  def african_dino_import
    CSV.foreach("african_dinosaur_export.csv", csv_header_converters) do |dino|
      african_dino = {
        name: dino[:genus],
        period: dino[:period],
        continent: "Africa",
        diet: carnivore_to_diet(dino[:carnivore]),
        weight_in_lbs: dino[:weight],
        walking: dino[:walking],
      }
      @master_dinosaur_list << Dinosaur.new(african_dino)
    end
  end

  def carnivore_to_diet(diet)
    diet == "Yes" ? "Carnivore" : "Herbivore"
  end

  def dino_import
    CSV.foreach("dinodex.csv", csv_header_converters) do |dino|
      dinosaur = {
        name: dino[:name],
        period: dino[:period],
        continent: dino[:continent],
        diet: dino[:diet],
        weight_in_lbs: dino[:weight_in_lbs],
        walking: dino[:walking],
        description: dino[:description],
      }
      @master_dinosaur_list << Dinosaur.new(dinosaur)
    end
  end

  def biped_search
    Dinodex.new(@master_dinosaur_list.select(&:biped?))
  end

  def carnivore_search
    Dinodex.new(@master_dinosaur_list.select(&:carnivore?))
  end

  def period_search(period)
    Dinodex.new(@master_dinosaur_list.select { |dino| dino.period_name(period) })
  end

  def big
    Dinodex.new(@master_dinosaur_list.select(&:big?))
  end

  def small
    Dinodex.new(@master_dinosaur_list.select(&:small?))
  end

  def to_s
    array_of_strings = @master_dinosaur_list.map do |dinosaur|
      dinosaur.to_s
    end
    array_of_strings.join("\n")
  end

  def export_to_json(filename)
    dinosaur_data = @master_dinosaur_list.map(&:to_hash)
    File.open(filename, "w") do |f|
      f.write(JSON.pretty_generate dinosaur_data)
    end
  end
end
