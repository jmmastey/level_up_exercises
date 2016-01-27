require 'csv'
require 'pry'
require_relative 'dino'

class DinoCatalog
  attr_accessor :csv_array, :dino_array

  def initialize
    @csv_array = []
    @dino_array = [] 
  end

  def parse(csv_file)
    @csv_array = CSV.open(csv_file, 
                          :headers => true, 
                          :header_converters => :symbol,
                          :converters => :all)
  end

  def make_dinos
    @csv_array.each do |dino|
      @dino_array << Dino.new(dino[:name],
                              dino[:period],
                              dino[:continent],
                              dino[:diet], 
                              dino[:weight_in_lbs],
                              dino[:walking], 
                              dino[:description])
    end
  end
end
