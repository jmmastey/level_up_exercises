require_relative "dino_parser"

class DinoCollection
  attr_accessor :dinos

  def initialize
    @dinos = []
  end

  def add_from_csv(file_name)
    parser = DinoParser.new(file_name)
    parser.dinos.each do |dino|
      @dinos << dino
    end
  end

  def print_all
    puts "\n-----------------All The Dinos-----------------"
    puts dinos.map(&:to_s)
  end

  def print_bipeds
    puts "\n-----------------Bipeds-----------------"
    puts bipeds.map(&:to_s)
  end

  def print_meat_eaters
    puts "\n-----------------Meat eaters-----------------"
    puts meat_eaters.map(&:to_s)
  end

  def print_from_period(period)
    puts "\n-----------------Period (#{period})-----------------"
    puts from_period(period).map(&:to_s)
  end

  def print_weighs_more_than(weight)
    puts "\n-----------------Weighs more than #{weight} lbs-----------------"
    puts weighs_more_than(weight).map(&:to_s)
  end

  private

  def bipeds
    @dinos.select { |d| d.biped? }
  end

  def meat_eaters
    @dinos.select { |d| d.eats_meat? }
  end

  def from_period(period)
    @dinos.select { |d| d.from_period?(period) }
  end

  def weighs_more_than(weight)
    @dinos.select { |d| d.weight_in_lbs > weight }
  end
end

