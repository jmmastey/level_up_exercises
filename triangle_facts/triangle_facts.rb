# Killer facts about triangles AWW YEAH
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
    !(equilateral || isosceles)
  end

  def triangle_type
    puts 'This triangle is equilateral!' if equilateral
    puts 'This triangle is isosceles! Also, \
    that word is hard to type.' if isosceles
    puts 'This triangle is scalene and mathematically boring.' if scalene
  end

  def recite_facts
    triangle_type
    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
  end

  def law_of_cosines(x, y, z)
    radians_to_degrees(Math.acos((x**2 + y**2 - z**2) /
     (2.0 * x * y)))
  end

  def calculate_angles(a, b, c)
    [law_of_cosines(b, c, a),
    law_of_cosines(a, c, b),
    law_of_cosines(a, b, c),
    ]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each { |sides| Triangle.new(*sides).recite_facts }
