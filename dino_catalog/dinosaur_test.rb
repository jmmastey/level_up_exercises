require 'minitest/autorun'
require_relative 'dinosaur'

class DinosaurTest < MiniTest::Unit::TestCase
  def test_valid_initialize
    assert_equal 'Claw', Dinosaur.new(name: 'Claw').name
  end

  def test_valid_detect_carnivore
    assert_equal 'Yes', Dinosaur.new(name: 'Claw', diet: 'insectivore').carnivore
  end

  def test_valid_format_var_value
    assert_equal "Claw\n------", Dinosaur.new(name: 'Claw').format_var_value('@name')
  end

  def test_valid_format_var_name
    assert_equal "------\nName", Dinosaur.new(name: 'Claw').format_var_name('@name')
  end
end
