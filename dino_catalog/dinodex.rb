require 'csv'
require 'table_print'
#
class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :legs, :description
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent]
    @diet = convert_diet(options[:diet].to_s)
    @weight = options[:weight_in_lbs]
    @legs = convert_legs(options[:walking])
    @description = options[:description].to_s
  end

  def convert_continent(cont, name)
    if cont.nil?
      print "Where is the #{name} from? "
      gets.chomp
    else
      cont
    end
  end

  def convert_legs(legs)
    if legs.downcase == "biped"
      2
    elsif legs.downcase == "quadruped"
      4
    else
      "other"
    end
  end

  def convert_diet(food)
    if food.downcase == "yes"
      "Carnivore"
    elsif food.downcase == "no"
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
    "else" => :not_an_option,
  }

  attr_accessor :dinodex, :results
  def initialize
    @dinodex = []
    @results = []
    load_dinos('dinodex.csv')
    load_dinos('african_dinosaur_export.csv')
    tp @dinodex
    @results = @dinodex
    options
  end

  def load_dinos(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      dino = row.to_hash
      p dino
      mapping = { genus: :name, carnivore: :diet, weight: :weight_in_lbs }
      dino.keys.each { |k| dino[mapping[k]] = dino.delete(k) if mapping[k] }
      @dinodex << Dinosaur.new(dino)
    end
  end

  def options
    STDIN.gets
    system('clear')
    choice = gets.chomp
    choice = ACTION_MAP[choice] || ACTION_MAP["else"]
    send(choice)
  end

  def search
    found = []
    tp @results, :name
    print "What dino do you want to find?"
    selected = gets.chomp.downcase
    @results.each { |dino|found << dino if dino.name.downcase == selected }

    tp found
  end

  def bipeds
    new_results = []
    @results.each { |dino| new_results << dino if dino.legs == 2 }
    tp @results = new_results
    options
  end

  def carnivores
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.diet == "Carnivore"
    end
    tp @results = new_results
    options
  end

  def period
    print "Which Period1: Cretaceous\n2: Permian\n3: Jurassic\n4: Oxfordian\n5: Albian\n6: Triassic\nEnter Selection or type b to go back:"
    time_period = gets.chomp
    case time_period
      when "1"
        era("cretaceous")
      when "2"
        era("permian")
      when "3"
        era("jurassic")
      when "4"
        era("oxfordian")
      when "5"
        era("albian")
      when "6"
        era("triassica")
      when "b"
        exit
      else
        p "Incorrect choice"
        gets.chomp
    end
  end

  def era(time_period)
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.period.downcase.include?(time_period)
    end
    @results = new_results
    tp @results
    options
  end

  def big
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.weight.to_i > 4000
    end
    @results = new_results
    tp @results
    options
  end
end

Library.new
