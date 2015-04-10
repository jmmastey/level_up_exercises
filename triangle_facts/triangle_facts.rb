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
    # not (equilateral or isosceles)
    ! (equilateral || isosceles)
  end

  def recite_facts
    print_triangle_type(isosceles, equilateral, scalene)

    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')
    puts "This triangle is also a right triangle! \n" if angles.include?(90)
  end

  def calculate_angles(a, b, c)
    angle1 = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angle2 = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angle3 = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))
    [angle1, angle2, angle3]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def print_triangle_type(isosceles, equilateral, scalene)
    if isosceles
      puts 'This triangle is isosceles! Also, that word is hard to type.'
    end
    puts 'This triangle is equilateral!' if equilateral
    puts 'This triangle is scalene and mathematically boring.' if scalene
  end
end

# Testing script
triangles = [
  [5, 5, 5],
  [5, 12, 13],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
