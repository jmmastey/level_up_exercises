require "./arrowhead"
require "test/unit"

class TestArrowhead < Test::Unit::TestCase

  def test_arrowhead
    assert_equal("You have a(n) 'Oxbow' arrowhead. Probably priceless.", Arrowhead.classify(:northern_plains, :bifurcated))
    assert_equal("You have a(n) 'Archaic Stemmed' arrowhead. Probably priceless.", Arrowhead.classify(:far_west, :stemmed))
  end
  
end