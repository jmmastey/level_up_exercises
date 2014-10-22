require 'pry'
# jlynch - Determines which type and angles of triangle given sides
# Talking to Ozzie he said no @angles - no caching those angles!
class Triangle
  attr_accessor :sides

  def initialize(side1, side2, side3)
    @sides = { side1: side1, side2: side2, side3: side3 }
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

  def angles
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
  tri.sides[:side1] = 4
  tri.recite_facts
end
