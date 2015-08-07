require 'set'

# Public: Provides descriptions and facts about triangles
#
# Examples
#
#   t = Triangle.new([5,5,5])
#   t.recite_facts
#
class Triangle

  # Public: Gets/Sets the lengths of the three sides
  attr_accessor :side_a, :side_b, :side_c

  # Public: Initialize a triangle
  #
  # side_a - The Integer length of the first side of the triangle
  # side_b - The Integer length of the second side of the triangle
  # side_c - The Integer length of the third side of the triangle
  #
  def initialize(side_a, side_b, side_c)
    @side_a, @side_b, @side_c = side_a, side_b, side_c
  end

  # Public: Is this an equilateral triangle?
  #
  # Returns a Boolean
  def equilateral?
    side_a === side_b && side_b === side_c
  end

  # Public: Is this an iscsceles triangle?
  #
  # Returns a Boolean
  def isosceles?
    Set.new([side_a,side_b,side_c]).length == 2
  end

  # Public: Is this a scalene triangle?
  #
  # Returns a Boolean
  def scalene?
    !(equilateral? || isosceles?)
  end

  # Public: Prints facts about the triangle
  #
  # Returns nothing.
  def recite_facts
    puts "Facts about a triangle described by side lengths of #{side_a}, #{side_b}, and #{side_c} units"
    puts "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles! Also, that word is hard to type." if isosceles?
    puts "This triangle is scalene and mathematically boring." if scalene?

    angles = calculate_angles
    puts "The angles of this triangle are #{ angles.join("\xC2\xB0, ") }\xC2\xB0"

    puts "This triangle is also a right triangle!" if angles.include? 90
    puts ""
  end

  # Internal: Calculates the inner angles based on the side length
  #
  # Returns the three angles in an Array
  def calculate_angles
    angle_a = radians_to_degrees(Math.acos((side_b**2 + side_c**2 - side_a**2) / (2.0 * side_b * side_c)))
    angle_b = radians_to_degrees(Math.acos((side_a**2 + side_c**2 - side_b**2) / (2.0 * side_a * side_c)))
    angle_c = radians_to_degrees(Math.acos((side_a**2 + side_b**2 - side_c**2) / (2.0 * side_a * side_b)))

    [angle_a, angle_b, angle_c]
  end

  # Internal: Converts radians to degrees
  #
  # Returns the angle in degrees as a Float
  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

end

puts ""
puts "*******************"
puts "* Triangle Facts! *"
puts "*******************"
puts ""

# Demonstrates the use of the class
[
  [5, 5, 5],    # Example Equilateral Triangle
  [5, 12, 13],  # Example Scalene Triangle
  [5, 10, 10],  # Example Isosceles Triangle
].each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
