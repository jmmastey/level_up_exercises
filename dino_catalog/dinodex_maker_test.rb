require 'minitest/autorun'
require_relative 'dinodex_maker'

class CSVParseTest < MiniTest::Unit::TestCase
  def test_make_dinodex
    dino_maker = DinodexMaker.new
    dinodex = dino_maker.make_dinodex(['dinodex.csv', 'african_dinosaur_export.csv'])
    dinodex.dinosaurs.each do |dinosaur|
      assert_equal true, dinosaur.is_a?(Dinosaur)
    end
  end
end
