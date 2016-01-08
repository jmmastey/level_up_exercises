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
    if !(equilateral? || isosceles?)
      true
    else
      false
    end
  end

  def recite_facts
    case
      when equilateral?
        'This triangle is equilateral!'
      when isosceles?
        'This triangle is isosceles! Also, that word is hard to type.'
      when scalene?
        'This triangle is scalene and mathematically boring.'
    end
  end

  def recite_angle_facts
    angles = calculate_angles(side1, side2, side3)

    result = "\nThe angles of this triangle are " + angles.join(',')

    if angles.include? 90
      result += "\nThis triangle is also a right triangle!\n\n"
    end

    result
  end

  def calculate_angles(a, b, c)
    [
      radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))),
      radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c))),
      radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))),
    ]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

[
  [5, 5, 5],
  [5, 12, 13],
].each do |sides|
  tri = Triangle.new(*sides)
  puts tri.recite_facts
  puts tri.recite_angle_facts
end
