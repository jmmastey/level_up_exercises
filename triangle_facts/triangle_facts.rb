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
    !(equilateral || isosceles)
  end

  def recite_facts
    case
      when equilateral
        puts "This triangle is equilateral!"
      when isosceles
        puts "This triangle is isosceles! Also, that word is hard to type."
      when scalene
        puts "This triangle is scalene and mathematically boring."
    end

    angles = calculate_angles
    puts "The angles of this triangle are " + angles.join(",")
    puts "This triangle is also a right triangle!" if angles.include?(90)
    puts ""
  end

  def calculate_angles
    angle_a = radians_to_degrees(Math.acos((side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3)))
    angle_b = radians_to_degrees(Math.acos((side1**2 + side3**2 - side2**2) / (2.0 * side1 * side3)))
    angle_c = radians_to_degrees(Math.acos((side1**2 + side2**2 - side3**2) / (2.0 * side1 * side2)))
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
  triangle = Triangle.new(*sides)
  triangle.recite_facts
end
