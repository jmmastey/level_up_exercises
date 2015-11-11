require 'pry'

PI = 3.14

class Triangle
  attr_reader :side1, :side2, :side3, :triangle_sides

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
    @triangle_sides = [side1, side2, side3]
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    triangle_sides.uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def rads_to_degs(rads)
    (rads * 180 / Math::PI).round
  end

  def calc_angle(first, second, third)
    side_calc = (second**2 + third**2 - first**2) / (2.0 * second * third)
    rads_to_degs(Math.acos(side_calc))
  end

  def calculate_angles
    angle_a = calc_angle(side1, side2, side3)
    angle_b = calc_angle(side2, side1, side3)
    angle_c = calc_angle(side3, side1, side2)
    [angle_a, angle_b, angle_c]
  end

  def prints(triangle_type, secondary = nil)
    puts "This triangle is #{triangle_type} #{secondary}"
  end

  def print_triangle_type
    prints("equilateral!") if equilateral?
    prints("isosceles!", "Also, that word is hard to type.") if isosceles?
    prints("scalene", "and mathematictriangle_sidesy boring.") if scalene?
  end

  def print_triangle_angles
    angles = calculate_angles
    puts "The angles of this triangle are #{angles.join(',')}"
    puts "This triangle is also a right triangle!" if angles.include? 90
    puts ""
  end

  def recite_facts
    print_triangle_type
    print_triangle_angles
  end

  private :rads_to_degs, :calc_angle, :calculate_angles
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]
triangles.each do |sides|
  Triangle.new(*sides).recite_facts
end
