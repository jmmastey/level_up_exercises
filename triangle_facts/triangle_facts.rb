# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral
    side1 == side2 && side2 == side3
  end

  def isosceles
    [side1, side2, side3].uniq.length == 2
  end

  def scalene
    equilateral || isosceles
  end

  def print_equilateral
    puts 'This triangle is equilateral!' if equilateral
  end

  def print_isosceles
    puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles
  end

  def print_scalene
    'This triangle is scalene and mathematically boring.' if scalene
  end

  def recite_facts
    print_equilateral
    print_isosceles
    print_scalene

    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    angle_a = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angle_b = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angle_c = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

    [angle_a, angle_b, angle_c]
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
