# jlynch - Determines which type and angles of triangle given sides
require 'pry'

class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def is_equilateral?
    # side1 is a method.  Created by attr_accessor that gets @side1
    (side1 == side2) && (side2 == side3)
  end

  def is_isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def is_scalene?
    true unless (is_equilateral? || is_isosceles?)
  end

  def recite_facts
    puts "This triangle is equilateral!" if is_equilateral?
    puts "This triangle is isosceles! Also, that word is hard to type." if is_isosceles?
    puts "This triangle is scalene and mathematically boring." if is_scalene?
    puts "The angles of this triangle are #{calculate_angles.join(', ')}"
    puts "This triangle is also a right triangle!" if calculate_angles.include? 90
    puts ""
  end

  def calculate_angles
    angleA = radians_to_degrees(Math.acos((side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3)))
    angleB = radians_to_degrees(Math.acos((side1**2 + side3**2 - side2**2) / (2.0 * side1 * side3)))
    angleC = radians_to_degrees(Math.acos((side1**2 + side2**2 - side3**2) / (2.0 * side1 * side2)))

    return [angleA, angleB, angleC]
  end

  def law_of_cosines(sides)
    radians_to_degrees(Math.acos((sides[0]**2 + sides[1]**2 - sides[2]**2) / (2.0 * sides[0] * sides[1])))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
