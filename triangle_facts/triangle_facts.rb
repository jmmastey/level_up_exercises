# killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def equilateral
    side1 == side2 && side2 == side3
  end

  def isosceles
    [side1, side2, side3].uniq.length == 2
  end

  def scalene
    true if equilateral || isosceles
  end

  def side_facts
    puts 'This triangle is equilateral!' if equilateral
    puts 'This triangle is isosceles! Also, that word is hard to type.' if
    isosceles
    puts 'This triangle is scalene and mathematically boring.' if scalene
    puts 'The angles of this Triangle are ' + angle_facts.join(',')
    puts 'This triangle is also a right Triangle!' if angle_facts.include? 90
    puts ''
  end

  def angle_facts
    [angle_a(side1, side2, side3), angle_b(side1, side2, side3),
     angle_c(side1, side2, side3)]
  end

  def right_triangle?
  end

  def angle_a(a, b, c)
    radians_to_degrees Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))
  end

  def angle_b(a, b, c)
    radians_to_degrees Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c))
  end

  def angle_c(a, b, c)
    radians_to_degrees Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.side_facts
  tri.angle_facts
end
