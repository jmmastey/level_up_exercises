require 'csv'
require 'table_print'
#
class Dinosaur
    attr_reader :name, :period, :continent, :diet, :weight_in_lbs, :legs, :description
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent].to_s
    @diet = convert_diet(options[:diet].to_s)
    @weight_in_lbs = options[:weight_in_lbs].to_i
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
    print "\nPress Enter to Continue\n"
    STDIN.gets
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
    system('clear')
    print "Options\n1: Find Bipeds \n2: Find Carnivores \n3: Find Dinosaurs by Period \n4: Find BIG Dinosaurs\n5: Reset Filters \n6: Print Results\nQ: Quit\nWhat would you like to do? "
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
      reset_filters
    when "6"
      print_results
    when "Q"
      exit
    else
      p "Incorrect choice"
      choice = gets.chomp
    end
  end

  def bipeds
    if results.length > 0
      new_results = []
      @results.each do |dino|
        new_results << dino if dino.legs == 2
      end
      @results = new_results
      tp @results
    else
      @dinodex.each do |dino|
        @results << dino if dino.legs == 2
      end
      tp @results
    end
    STDIN.gets
    options
  end

  def carnivores
    if results.length > 0
      new_results = []
      @results.each do |dino|
        new_results << dino if dino.diet.downcase == "carnivore"
      end
      @results = new_results
      tp @results
    else
      @dinodex.each do |dino|
        @results << dino if dino.diet.downcase == "carnivore"
      end
      tp @results
    end
    STDIN.gets
    options
  end

  def period
  end

end

  dinos = Library.new('dinodex.csv')
