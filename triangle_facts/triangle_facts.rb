# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    false if equilateral? || isosceles?
  end

  def recite_facts
    type_of_triangle

    angles = calculate_angles(side1, side2, side3)

    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90

    puts ''
  end

  def type_of_triangle
    puts 'This triangle is equilateral' if equilateral?

    puts 'This triangles is isoceles' if isosceles?

    puts 'This triangles is scalene'  if scalene?
  end

  def calculate_included_angle(a, b, c)
    radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
  end

  def calculate_angles(a, b, c)
    [calculate_included_angle(a, b, c), calculate_included_angle(a, c, b),
     calculate_included_angle(b, c, a)]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13]
]

triangles.each do |sides|
  Triangle.new(*sides).recite_facts
end
