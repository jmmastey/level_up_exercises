require 'minitest/autorun'
require_relative 'dinodex'
require_relative 'dinodex_maker'

class DinodexTest < MiniTest::Unit::TestCase
  def test_bipeds
  dinodex = DinodexMaker.new.make_dinodex(['dinodex.csv'])
    dinodex.bipeds.dinosaurs.each do |dino|
      assert_equal 'Biped', dino.walking
    end
  end

  def test_carnivores
  dinodex = DinodexMaker.new.make_dinodex(['dinodex.csv'])
    dinodex.carnivores.dinosaurs.each do |dino|
      assert_equal 'Yes', dino.carnivore
    end
  end

  def test_period
  dinodex = DinodexMaker.new.make_dinodex(['dinodex.csv'])
    dinodex.period('Jurrasic').dinosaurs.each do |dino|
      assert_equal 'Jurassic', dino.period
    end
  end
end
