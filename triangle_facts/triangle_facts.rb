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
    puts "Facts about a triangle described by side lengths of " \
         "#{side_a}, #{side_b}, and #{side_c} units"
    puts "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles!" if isosceles?
    puts "This triangle is scalene!" if scalene?

    angles = calculate_angles
    puts "The angles of this triangle are #{angles.join("\xC2\xB0, ")}\xC2\xB0"

    puts "This triangle is also a right triangle!" if angles.include? 90
    puts ""
  end

  # Internal: Calculates the inner angles based on the side length
  #
  # Returns the three angles in an Array
  def calculate_angles
    angle_a = radians_to_degrees(calculate_angle(side_b, side_c, side_a))
    angle_b = radians_to_degrees(calculate_angle(side_a, side_c, side_b))
    angle_c = radians_to_degrees(calculate_angle(side_a, side_b, side_c))

    [angle_a, angle_b, angle_c]
  end

  # Internal: Calculate angle in radians
  #
  # left  - The Integer length of the side adjacent to the left of the angle
  # right - The Integer length of the side adjacent to the right of the angle
  # trans - The Integer length of the transversal side opposite the angle
  #
  # Returns the angle in degrees as a Float
  def calculate_angle(left, right, trans)
    Math.acos((left**2 + right**2 - trans**2) /( 2.0 * left * right))
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
