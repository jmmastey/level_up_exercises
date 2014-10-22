require 'pry'
# jlynch - Determines which type and angles of triangle given sides
# wanted to the program to know to recalculate angles if one side was changed
# without having to create a completely new triangle object.
class Triangle
  attr_reader :sides

  def initialize(side1, side2, side3)
    @sides = { side1: side1, side2: side2, side3: side3 }
  end

  # creating custom setter method so that if a one side is changed
  # angles are set to nil, and angles function knows to recalculate
  # I would repeat for side2, side3 --> for now it just does side1
  def side_setter=(new_side_length)
    @sides.merge!({ side1: new_side_length })
    @angles = nil
    angles
  end

  def angles
    @angles ||= calculate_angles_from_sides
  end

  def is_equilateral?
    (sides[:side1] == sides[:side2]) && (sides[:side2] == sides[:side3])
  end

  def is_isosceles?
    sides.to_a.uniq.length == 2
  end

  def is_scalene?
    true unless is_equilateral? || is_isosceles?
  end

  def recite_facts
    print "This triangle: #{ self.object_id }, is "
    puts "equilateral!" if is_equilateral?
    puts "isosceles! Also, that word is hard to type." if is_isosceles?
    puts "scalene and mathematically boring." if is_scalene?
    puts "The angles of this triangle are #{ angles.join(', ') }"
    puts "This triangle is also a right triangle!" if angles.include? 90
    puts ""
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  private

  def calculate_angles_from_sides
    angle_a = radians_to_degrees(Math.acos((sides[:side2]**2 + sides[:side3]**2 - sides[:side1]**2) / (2.0 * sides[:side2] * sides[:side3])))
    angle_b = radians_to_degrees(Math.acos((sides[:side1]**2 + sides[:side3]**2 - sides[:side2]**2) / (2.0 * sides[:side1] * sides[:side3])))
    angle_c = radians_to_degrees(Math.acos((sides[:side1]**2 + sides[:side2]**2 - sides[:side3]**2) / (2.0 * sides[:side1] * sides[:side2])))
    return [angle_a, angle_b, angle_c]
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
  print "Let's change side 1 to 4in ... "
  tri.side_setter = 4
  tri.recite_facts
end
