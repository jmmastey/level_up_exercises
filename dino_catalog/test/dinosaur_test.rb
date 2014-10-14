require 'minitest/autorun'
require_relative '../dinosaur.rb'

class TestDinosaur < MiniTest::Unit::TestCase
  def test_period_should_make_no_disctinction_in_various_cretaceous_periods
    dinosaur = Dinosaur.new period: "Early Cretaceous"
    assert_equal("Cretaceous", dinosaur.period)
  end

  def test_should_be_small_dinosaur_when_4500lbs
    dinosaur = Dinosaur.new weight_in_lbs: 4500
    assert_equal(true, dinosaur.big_dinosaur?)
  end

  def test_should_be_small_dinosaur_when_500lbs
    dinosaur = Dinosaur.new weight_in_lbs: 500
    assert_equal(false, dinosaur.big_dinosaur?)
  end

  def test_should_be_carnivore_when_diet_is_piscivore
    dinosaur = Dinosaur.new diet: 'Piscivore'
    assert_equal(true, dinosaur.carnivore?)
  end

  def test_should_be_carnivore_when_diet_is_insectivore
    dinosaur = Dinosaur.new diet: 'Insectivore'
    assert_equal(true, dinosaur.carnivore?)
  end

  def test_should_not_be_carnivore_when_diet_is_herbivore
    dinosaur = Dinosaur.new diet: 'Herbivore'
    assert_equal(false, dinosaur.carnivore?)
  end

  def test_should_be_carnivore_when_diet_is_nil
    dinosaur = Dinosaur.new
    assert_equal(false, dinosaur.carnivore?)
  end
end
