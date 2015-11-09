require "./arrowhead"
require "test/unit"

class TestArrowhead < Test::Unit::TestCase
  def test_arrowhead
    expected = "You have a(n) 'Oxbow' arrowhead. Probably priceless."
    assert_equal(expected, Arrowhead.classify(:northern_plains, :bifurcated))
    
    expected = "You have a(n) 'Archaic Stemmed' arrowhead. Probably priceless."
    assert_equal(expected, Arrowhead.classify(:far_west, :stemmed))
  end
end
