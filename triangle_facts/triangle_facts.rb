# Killer facts about triangles AWW YEAH
class Triangle
  (1..3).each do |side|
    define_method("side#{side}") { @sides[side - 1] }
  end

  def initialize(*sides)
    raise "Triangle requires 3 sides." unless sides.length == 3
    @sides = sides
  end

  def equilateral?
    @sides.uniq.length == 1
  end

  def isosceles?
    @sides.uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def recite_facts
    if equilateral?
      puts "This triangle is equilateral!"
    elsif isosceles?
      puts "This triangle is isosceles! Also, that word is hard to type."
    elsif scalene?
      puts "This triangle is scalene and mathematically boring."
    end
    angles = calculate_angles(@sides)
    puts "The angles of this triangle are #{angles.join(",")}"
    puts "This triangle is also a right triangle!" if angles.include?(90)
  end

  def calculate_angles(sides)
    [to_angle(sides), to_angle(sides.rotate), to_angle(sides.rotate(2))]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def to_angle(sides)
    radians_to_degrees(Math.acos((sides[1]**2 + sides[2]**2 - sides[0]**2) /
                       (2.0 * sides[1] * sides[2])))
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
