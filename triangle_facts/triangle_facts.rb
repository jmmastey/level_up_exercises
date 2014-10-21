require 'pry'
# jlynch - Determines which type and angles of triangle given sides
class Triangle
  attr_reader :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def angles
    @angles ||= calculate_angles_from_sides
  end

  # creating custom attribute writer methods so that if a side is changed
  # angles are set to nil, and angles function knows to recalculate
  def side1=(side_size)
    @angles = nil
    @side1 = side_size
  end

  def side2=(side_size)
    @angles = nil
    @side2 = side_size
  end

  def side3=(side_size)
    @angles = nil
    @side3 = side_size
  end

  def is_equilateral?
    # side1 is a method.  Created by attr_accessor that gets @side1
    (side1 == side2) && (side2 == side3)
  end

  def is_isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def is_scalene?
    true unless is_equilateral? || is_isosceles?
  end

  def recite_facts
    puts "This triangle is equilateral!" if is_equilateral?
    puts "This triangle is isosceles! Also, that word is hard to type." if is_isosceles?
    puts "This triangle is scalene and mathematically boring." if is_scalene?
    puts "The angles of this triangle are #{@angles.join(', ')}"
    puts "This triangle is also a right triangle!" if @angles.include? 90
    puts ""
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  private

  def calculate_angles_from_sides
    angle_a = radians_to_degrees(Math.acos((side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3)))
    angle_b = radians_to_degrees(Math.acos((side1**2 + side3**2 - side2**2) / (2.0 * side1 * side3)))
    angle_c = radians_to_degrees(Math.acos((side1**2 + side2**2 - side3**2) / (2.0 * side1 * side2)))
    return [angle_a, angle_b, angle_c]
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
