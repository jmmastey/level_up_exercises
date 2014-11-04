require 'csv'
require 'table_print'

#
class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :legs, :description
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent] || "Africa"
    @diet = convert_diet(options[:diet])
    @weight = options[:weight_in_lbs] || "Unknown"
    @legs = options[:walking].to_s
    @description = options[:description].to_s
  end

  def convert_diet(food)
    if food == "Yes"
      "Carnivore"
    elsif food == "No"
      "Herbivore"
    else
      food
    end
  end
end

class Library
  ACTION_MAP = {
    "bipeds" => :bipeds,
    "search" => :search,
    "carnivores" => :carnivores,
    "big" => :big,
    "reset" => :reset,
    "q" => :quit,
    "period" => :period,
    "print" => :print,
    "else" => :not_an_option,
  }

  attr_accessor :dinodex, :results
  def initialize
    @dinodex = []
    @results = []
    @found = []
    load_dinos('dinodex.csv')
    load_dinos('african_dinosaur_export.csv')
    options
  end

  def load_dinos(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      dino = row.to_hash
      mapping = { genus: :name, carnivore: :diet, weight: :weight_in_lbs }
      dino.keys.each { |k| dino[mapping[k]] = dino.delete(k) if mapping[k] }
      @dinodex << Dinosaur.new(dino)
    end
  end

  def options
    @results = @dinodex
    system('clear')
    print_options
    choice = gets.chomp
    choice = ACTION_MAP[choice] || ACTION_MAP["else"]
    send(choice)
  end

  def search
    tp @results, :name
    print "What dino do you want to find?"
    selected = gets.chomp.downcase
    @results.each { |dino| @found << dino if dino.name.downcase == selected }
    tp @found
    STDIN.gets
    options
  end

  def bipeds
    new_results = []
    @results.each { |dino| new_results << dino if dino.legs == "Biped" }
    tp @results = new_results
    STDIN.gets
  end

  def carnivores
    filtered = []
    meat = %w(Insectivore Piscivore Carnivore)
    @results.each { |dino| filtered << dino if meat.include?(dino.diet) }
    tp @results = filtered
    STDIN.gets
  end

  def period
    p "Which Period?"
    time_period = gets.chomp
    era(time_period)
  end

  def era(time_period)
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.period.downcase.include?(time_period)
    end
    @results = new_results
    tp @results
  end

  def big
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.weight.to_i > 4000
    end
    @results = new_results
    tp @results
  end

  def not_an_option
    p "Not a valid option, Please try again"
    sleep(1)
  end

  def print_options
    puts "WELCOME TO DINODEX\nA repository for amazing Dinosaur knowledge"
    puts ""
  end
end

Library.new
