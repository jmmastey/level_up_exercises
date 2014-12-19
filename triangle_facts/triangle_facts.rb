# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side_1, :side_2, :side_3

  def initialize(side_1, side_2, side_3)
    @side_1 = side_1
    @side_2 = side_2
    @side_3 = side_3
  end

  def equilateral?
    side_1 == side_2 && side_2 == side_3
  end

  def isosceles?
    [side_1, side_2, side_3].uniq.length == 2
  end

  def scalene?
    !(equilateral || isosceles)
  end

  def recite_facts
    case
    when equilateral? then puts "This triangle is equilateral!"
    when isosceles? then puts "This triangle is isosceles! Also, that word is hard to type."
    else puts "This triangle is scalene and mathematically boring."
    end

    recite_angle_facts
  end
  
  def recite_angle_facts
    angles = calculate_angles(side_1, side_2, side_3)
    puts "The angles of this triangle are #{angles.join(",")}"
    puts "This triangle is also a right triangle!" if angles.include? 90
  end
  
  def calculate_angles(a, b, c)
    angle_A = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angle_B = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angle_C = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))
    [angle_A, angle_B, angle_C]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
  
end

triangles = [
  [5, 5, 5],
  [5, 12, 13]
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
