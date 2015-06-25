# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def recite_facts
    display_triangle_type

    angles = calculate_angles
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle.' if angles.include? 90
    puts ''
  end

  private

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    ! (equilateral? || isosceles?)
  end

  def display_triangle_type
    puts 'This triangle is equilateral.' if equilateral?
    puts 'This triangle is isosceles.'   if isosceles?
    puts 'This triangle is scalene.'     if scalene?
  end

  def angle_in_degrees(a, b, c)
    radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
  end

  def calculate_angles
    [
      angle_in_degrees(side1, side2, side3),
      angle_in_degrees(side2, side3, side1),
      angle_in_degrees(side3, side1, side2),
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

triangles.each do |sides|
  Triangle.new(*sides).recite_facts
end
