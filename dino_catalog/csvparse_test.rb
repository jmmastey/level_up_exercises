require 'minitest/autorun'
require_relative 'csvparse'

class CSVParseTest < MiniTest::Unit::TestCase
  def test_valid_initialize
    dinosaurs = CSVParse.new.parse_csv('dinodex.csv')
    dinosaurs.each do |dinosaur|
      assert_equal true, dinosaur.is_a?(Dinosaur)
    end
  end
end
