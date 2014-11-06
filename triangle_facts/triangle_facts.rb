# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
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

  def right?
    angles = calculate_angles(side1, side2, side3)
    angles.include? 90
  end

  def recite_facts
    puts triangle_type

    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')
    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def triangle_type
    return @facts[:equalateral] if equalateral?
    return @facts[:isosceles] if isosceles?
    return @facts[:scalene] if scalene?
    'Are you sure this is even a triangle?'
  end

  def calculate_angles(a, b, c)
    [angle_a(a, b, c), angle_b(a, b, c), angle_c(a, b, c)]
  end

  def angle_a(a, b, c)
    radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2 * b * c)))
  end

  def angle_b(a, b, c)
    radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2 * a * c)))
  end

  def angle_c(a, b, c)
    radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2 * a * b)))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  @facts = {
    equalateral: 'This triangle is equilateral!',
    isosceles: 'This triangle is isosceles! Also, that word is hard to type.',
    scalene: 'This triangle is scalene and mathematically boring.',
  }
end

#
triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
