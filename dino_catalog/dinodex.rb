require 'csv'
require 'table_print'
#
class Dinosaur
    attr_reader :name, :period, :continent, :diet, :weight, :legs, :description
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent].to_s
    @diet = convert_diet(options[:diet].to_s)
    @weight = options[:weight_in_lbs].to_i
    @legs = convert_legs(options[:walking])
    @description = options[:description].to_s
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
  attr_accessor :dinodex, :results


  def initialize(file)
    @dinodex = []
    @results = []
    load_dinos('dinodex.csv')
    load_dinos('african_dinosaur_export.csv')
    system('clear')
    tp @dinodex
    @results = @dinodex
    options
  end

  def load_dinos(file)
    CSV.foreach(file, :headers=> true) do |row|
      dino = row.to_hash
      mapping = {"Genus" => "Name", "Carnivore" => "Diet", "Weight" => "Weight_in_lbs"}
      dino.keys.each { |k| dino[mapping[k]] = dino.delete(k) if mapping[k]}
      dino = dino.inject({}){|memo,(k,v)| memo[k.downcase.to_sym] = v; memo}
      @dinodex << Dinosaur.new(dino)
    end
  end

  def options
    STDIN.gets
    system('clear')
    print "Options\n1: Find Bipeds \n2: Find Carnivores \n3: Find Dinosaurs by Period \n4: Find BIG Dinosaurs\n5: Reset Filters \n6: Print Results\n7: Search Results\nQ: Quit\nWhat would you like to do? "
    choice = gets.chomp
    case choice
    when "1"
      bipeds
    when "2"
      carnivores
    when "3"
      period
    when "4"
      big
    when "5"
      @results = @dinodex
      options
    when "6"
      tp @results
      options
    when "7"
      search
    when "Q"
      exit
    else
      p "Incorrect choice"
      choice = gets.chomp
    end
  end

  def search
    found =[]
    tp @results, :name
    print "\nWhat dino do you want to find?"
    selected = gets.chomp
    @results.each do |dino|
      found << dino if dino.name.downcase == selected.downcase
    end
    tp found
  end
  def bipeds
      new_results = []
      @results.each do |dino|
        new_results << dino if dino.legs == 2
      end
      @results = new_results
      tp @results
    options
  end

  def carnivores
      new_results = []
      @results.each do |dino|
        new_results << dino if dino.diet.downcase == "carnivore"
      end
      @results = new_results
      tp @results
    options
  end

  def period
    print "Which Period would you like to see Dinosaurs from?\n1: Cretaceous\n2: Permian\n3: Jurassic\n4: Oxfordian\n5: Albian\n6: Triassic\nEnter Selection or type b to go back:"
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
      time_period = gets.chomp
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
      new_results << dino if dino.weight > 4000
    end
    @results = new_results
    tp @results
    options
  end
end

  dinos = Library.new('dinodex.csv')
