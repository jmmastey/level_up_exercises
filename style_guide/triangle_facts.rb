# Killer facts about triangles AWW YEAH
class Triangle
  attr_reader :side1,:side2,:side3

  def initialize(side1,side2,side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end
  def
  isosceles?
    [side1,side2,side3].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles)
  end

  def recite_facts
    if equilateral?
      puts "\nThis triangle is equilateral!"
    elsif isosceles?
      puts "\nThis triangle is isosceles! Also, that word is hard to type."
    elsif scalene?
      puts "\nThis triangle is scalene and mathematically boring."
    end
    angles = calculate_angles
    puts "The angles of this triangle are #{angles.join(', ')}"
    if angles.include? 90
      puts "This triangle is also a right triangle!"
    end
  end

  def calculate_angles
    angleA = radians_to_degrees(sides_to_radians(@side2,@side3,@side1))
    angleB = radians_to_degrees(sides_to_radians(@side3,@side1,@side2))
    angleC = radians_to_degrees(sides_to_radians(@side1,@side2,@side3))
    [angleA, angleB, angleC]
  end

  def sides_to_radians(side_a,side_b,side_c)
    Math.acos((side_a**2 + side_b**2 - side_c**2) / (2.0 * side_a * side_b))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end


triangles = [
    [5,5,5],
    [22,22,12],
]
triangles.each { |sides|
  triangle = Triangle.new(*sides)
  triangle.recite_facts
}