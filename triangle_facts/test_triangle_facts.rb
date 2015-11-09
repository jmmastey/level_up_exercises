require "./triangle_facts"
require "test/unit"

class TestTriangleFacts < Test::Unit::TestCase

  def test_triangle_facts
    triangle_1 = Triangle.new(5, 5, 5)
    assert_equal("60,60,60", triangle_1.recite_facts)
    
    triangle_2 = Triangle.new(5, 12, 13)
    assert_equal("23,67,90", triangle_2.recite_facts)
    
    triangle_3 = Triangle.new(3, 4, 5)
    assert_equal("37,53,90", triangle_3.recite_facts)
  end
end