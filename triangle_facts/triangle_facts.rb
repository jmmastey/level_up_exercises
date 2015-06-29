
# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def recite_facts
    puts equilateral || isosceles || scalene
    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')
    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def equilateral
    return false unless side1 == side2 && side2 == side3
    'This triangle is equilateral!'
  end

  def isosceles
    return false unless [side1, side2, side3].uniq.length == 2
    puts 'This triangle is isosceles! Also, that word is hard to type.'
  end

  def scalene
    return false if equilateral || isosceles
    'This triangle is scalene and mathematically boring.'
  end

  def calculate_angles(a, b, c)
    [radians_to_degrees(get_radians(a, b, c)),
     radians_to_degrees(get_radians(b, c, a)),
     radians_to_degrees(get_radians(c, b, a)),
    ]
  end

  def get_radians(a, b, c)
    Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))
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
  tri.recite_facts
end
