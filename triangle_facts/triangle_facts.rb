# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    @side1 == @side2 && @side2 == @side3
  end

  def isosceles?
    [@side1, @side2, @side3].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def recite_facts
    puts(shape_type_msg)
    puts(angles_type_msg)
  end

  def shape_type_msg
    return 'This triangle is equilateral' if equilateral?
    return 'This triangle is scalene and mathematically boring.' if scalene?
    'This triangle is isosceles! Also, that word is hard to type.'
  end

  def angles_type_msg
    angles = calculate_angles
    msg = "The angles of this triangle are #{angles.join(',')}\n"
    msg << "This triangle is also a right triangle!\n" if angles.include?(90)
  end

  def calculate_angles
    [
      calculate_angle(@side1, @side2, @side3),
      calculate_angle(@side2, @side1, @side3),
      calculate_angle(@side3, @side1, @side2),
    ]
  end

  def self.calculate_angle(main_angle, a, b)
    numerator   = a**2 + b**2 - main_angle**2
    denominator = 2.0 * a * b
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def self.radians_to_degrees(rads)
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
