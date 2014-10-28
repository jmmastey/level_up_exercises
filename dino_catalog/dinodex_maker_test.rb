require 'minitest/autorun'
require_relative 'dinodex_maker'

class CSVParseTest < MiniTest::Unit::TestCase
  CSVS = ['dinodex.csv', 'african_dinosaur_export.csv']
  def test_make_dinodex
    dino_maker = DinodexMaker.new
    dinodex = dino_maker.make_dinodex(CSVS)
    dinodex.dinosaurs.each do |dinosaur|
      assert_equal true, dinosaur.is_a?(Dinosaur)
    end
  end
end
