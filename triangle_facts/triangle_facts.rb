# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side_1, :side_2, :side_3

  def initialize(side_1, side_2, side_3)
    @side_1 = side_1
    @side_2 = side_2
    @side_3 = side_3
  end

  def equilateral?
    (side_1 == side_2) && (side_2 == side_3)
  end

  def isosceles?
    [side_1, side_2, side_3].uniq.length == 2
  end

  def scalene?
    !equilateral? && !isosceles?
  end

  def right_triangle?
    angles.include?(90)
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equilateral?
    puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles? 
    puts 'This triangle is scalene and mathematically boring.' if scalene?
    puts 'The angles of this triangle are ' + angles.join(',')
    puts 'This triangle is also a right triangle!' if right_triangle?
    puts ''
  end

  private

  def angles
    [ included_angle(side_1, side_2, side_3), 
      included_angle(side_1, side_3, side_2), 
      included_angle(side_2, side_3, side_1)
    ]
  end

  def included_angle(a,b,c)
    angle = Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
    radians_to_degrees(angle)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

end


triangles = [
  [5,5,5],
  [5,12,13],
]
triangles.each { |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
}
