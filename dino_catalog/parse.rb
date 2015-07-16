require 'csv'
require_relative './dinosaur.rb'
require 'pry'

class Parser
  FILES = %w(dinodex.csv african_dinosaur_export.csv)

  attr_reader :dinos

  def parse
    @dinos = []
    FILES.each do |file|
      csv = CSV.open(file)
      @header = csv.first.map(&:downcase)
      @data = csv.to_a[1..-1]
      build_dino_array
    end
  end

  def handle_weight
    index = @header.index("weight_in_lbs")
    @header[index] = "weight" if index
  end

  def handle_name
    index = @header.index("genus")
    @header[index] = "name" if index
  end

  def handle_diet
    index = @header.index("carnivore")
    @header[index] = "diet" unless index.nil?
    adjust_diet_values(index) if index
  end

  def fix_discrepancies
    handle_weight
    handle_name
    handle_diet
  end

  def adjust_diet_values(index)
    @data.each do |row|
      if !index.nil? && row[index] == "Yes"
        row[index] = "Carnivore"
      elsif !index.nil?
        row[index] = nil
      end
    end
  end

  def build_dino_array
    fix_discrepancies
    @header = @header & Dinosaur::WHITELIST_ATTR
    @data.map do |row|
      args = @header.zip(row).to_h
      dino = Dinosaur.new(args)
      @dinos << dino
    end
  end
end
