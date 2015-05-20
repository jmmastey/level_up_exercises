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
    equilateral? || isosceles?
  end

  def recite_facts
    p 'This triangle is equilateral!' if equilateral?
    p 'This triangle is isosceles! Also, that word is hard to type.' if isosceles?
    p 'This triangle is scalene? and mathematically boring.' if scalene?
    angles = calculate_angles(side1, side2, side3)
    p 'The angles of this triangle are ' + angles.join(', ')
    p 'This triangle is also a right triangle!' if angles.include? 90
  end

  def calculate_angles(a, b, c)
    angle_a = radians_to_degrees(calculate_radians_angle_a(a, b, c))
    angle_b = radians_to_degrees(calculate_radians_angle_b(a, b, c))
    angle_c = radians_to_degrees(calculate_radians_angle_c(a, b, c))

    [angle_a, angle_b, angle_c]
  end

  def calculate_radians_angle_a(a, b, c)
    Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))
  end

  def calculate_radians_angle_b(a, b, c)
    Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c))
  end

  def calculate_radians_angle_c(a, b, c)
    Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
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
