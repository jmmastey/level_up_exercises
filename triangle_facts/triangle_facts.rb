# Killer facts about triangles AWW YEAH
require 'pry'
class Triangle
  attr_reader :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def recite_facts
    puts type_facts(side1, side2, side3)
    puts angle_facts(side1, side2, side3) + "\n\n"
  end

  def type_facts(side1, side2, side3)
    case triangle_type(side1, side2, side3)
      when :equilateral
        'This triangle is equilateral!'
      when :isosceles
        'This triangle is isosceles! Also, that word is hard to type.'
      else 'This triangle is scalene and mathematically boring.'
    end
  end

  def angle_facts(side1, side2, side3)
    angles = calculate_angles(side1, side2, side3)
    "The angles of this triangle are #{angles.join(',')}" \
      "#{"\nThis triangle is also a right triangle!" if angles.include? 90}"
  end

  def triangle_type(side1, side2, side3)
    return :equilateral if side1 == side2 && side2 == side3
    return :isosceles   if [side1, side2, side3].uniq.length == 2
    :scalene
  end

  def calculate_angles(a, b, c)
    angle_a = rad_to_deg(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angle_b = rad_to_deg(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angle_c = rad_to_deg(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))
    [angle_a, angle_b, angle_c]
  end

  def rad_to_deg(rads)
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
