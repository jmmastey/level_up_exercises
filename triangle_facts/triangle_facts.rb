# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def recite_type
    print "This triangle is "

    puts "isosceles!" if isosceles?
    puts "equilateral!" if equilateral?
    puts "scalene." if scalene?
  end

  def recite_angles
    angles = calculate_angles(side1, side2, side3)
    puts "The angles of this triangle are #{angles.join(',')}"

    puts "This triangle is also a right triangle!" if angles.include? 90
  end

  def recite_facts
    recite_type
    recite_angles
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def find_angle(a, b, c)
    radians = Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
    radians_to_degrees(radians)
  end

  def calculate_angles(a, b, c)
    angle_a = find_angle(b, c, a)
    angle_b = find_angle(a, c, b)
    angle_c = find_angle(a, b, c)

    [angle_a, angle_b, angle_c]
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
  puts
end
