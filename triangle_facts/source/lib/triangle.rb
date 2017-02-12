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
    !(equilateral? || isosceles?)
  end

  def recite_facts
    recite_equilateral_facts if equilateral?
    recite_isosceles_facts if isosceles?
    recite_scalene_facts if scalene?
    recite_angle_facts
  end

  def calculate_angles(a, b, c)
    rads_a = Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))
    rads_b = Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c))
    rads_c = Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
    [
      radians_to_degrees(rads_a),
      radians_to_degrees(rads_b),
      radians_to_degrees(rads_c)
    ]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  private

  def recite_equilateral_facts
    puts 'This triangle is equilateral!'
  end

  def recite_isosceles_facts
    puts 'This triangle is isosceles! Also, that word is hard to type.'
  end

  def recite_scalene_facts
    puts 'This triangle is scalene and mathematically boring.'
  end

  def recite_right_triangle_facts
    puts 'This triangle is also a right triangle!'
  end

  def recite_angle_facts
    angles = calculate_angles(side1, side2, side3)
    puts "The angles of this triangle are #{angles.join(',')}"
    recite_right_triangle_facts if angles.include? 90
    puts ''
  end
end
