require 'csv'
require 'table_print'
require_relative 'printer'
require_relative 'dinosaur'
require 'pry'
require 'pry-nav'

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
    @dinodex, @results, @found = [], [], []
    load_dinos('dinodex.csv')
    load_dinos('african_dinosaur_export.csv')
    @results = @dinodex
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
    while 1 > 0
      system('clear')
      Printer.print_options
      choice = gets.chomp
      choice = ACTION_MAP[choice] || ACTION_MAP["else"]
      send(choice)
    end
  end

  def search
    tp @results, :name
    puts "What dino do you want to find?"
    selected = gets.chomp.downcase
    @results.each { |dino| @found << dino if dino.name.downcase == selected }
    Printer.print(@found)
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
    @results = filtered
    Printer.print(@results)
  end

  def period
    periods = []
    @dinodex.each { |dino| periods << dino.period }
    Printer.eras(periods.uniq)
    time_period = gets.chomp
    era(time_period)
  end

  def era(time_period)
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.period.downcase.include?(time_period.downcase)
    end
    @results = new_results
    Printer.print(@results)
  end

  def big
    new_results = []
    @results.each do |dino|
      new_results << dino if dino.weight.to_i > 4000
    end
    @results = new_results
    Printer.print(@results)
  end

  def not_an_option
    p "Not a valid option, Please try again"
    sleep(1)
  end

  def reset
    @results = @dinodex
  end

  def print
    Printer.print(@results)
  end

  def quit
    abort
  end
end

Library.new
