require 'set'

class Triangle
  attr_accessor :side_a, :side_b, :side_c

  DEGREE_SYMBOL = "\u00B0"

  def initialize(side_a, side_b, side_c)
    @side_a = side_a
    @side_b = side_b
    @side_c = side_c
  end

  def equilateral?
    side_a == side_b && side_b == side_c
  end

  def isosceles?
    [side_a, side_b, side_c].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def print_facts
    puts "Facts about a triangle described by side lengths of " \
         "#{side_a}, #{side_b}, and #{side_c} units"

    print_type
    print_angles
    puts
  end

  def print_type
    puts "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles!" if isosceles?
    puts "This triangle is scalene!" if scalene?
  end

  def print_angles
    angles = calculate_angles
    puts "The angles of this triangle are " \
         "#{angles.join("#{DEGREE_SYMBOL}, ")}#{DEGREE_SYMBOL}"
    puts "This triangle is also a right triangle!" if angles.include?(90)
  end

  def calculate_angles
    angle_a = calculate_angle(side_b, side_c, side_a)
    angle_b = calculate_angle(side_a, side_c, side_b)
    angle_c = calculate_angle(side_a, side_b, side_c)

    [angle_a, angle_b, angle_c]
  end

  def calculate_angle(left, right, trans)
    rads = Math.acos((left**2 + right**2 - trans**2) / (2.0 * left * right))
    radians_to_degrees(rads)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

puts
puts "*******************"
puts "* Triangle Facts! *"
puts "*******************"
puts

triangles = [
  [5, 5, 5],    # Equilateral
  [5, 12, 13],  # Scalene
  [5, 10, 10],  # Isosceles
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.print_facts
end
