# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    [side1, side2, side3].uniq.length == 1
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def triangle_type
    return "This triangle is equilateral!" if equilateral?
    return "This triangle is isosceles!" if isosceles?
    "This triangle is scalene and mathematically boring."
  end

  def recite_facts
    puts triangle_type

    angles = calculate_angles(side1, side2, side3)

    puts 'The angles of this triangle are ' + angles.map(&:to_s).join(', ')
    puts 'This triangle is also a right triangle!' if angles.include?(90)
    puts
  end

  def calculate_angles(a, b, c)
    angle_a = calculate_angle(a, b, c)
    angle_b = calculate_angle(b, a, c)
    angle_c = calculate_angle(c, a, b)
    [angle_a, angle_b, angle_c]
  end

  def calculate_angle(a, b, c)
    radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
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
