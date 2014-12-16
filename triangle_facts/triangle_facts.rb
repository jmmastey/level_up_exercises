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
    ! (equilateral? || isosceles?)
  end

  def angles
    @angles ||= calculate_angles
  end

  def right_triangle?
    angles.include? 90
  end

  def type_fact
    if equilateral?
      "This triangle is equilateral!"
    elsif isosceles?
      "This triangle is isosceles! Also, that word is hard to type."
    elsif scalene?
      "This triangle is scalene and mathematically boring."
    end
  end

  def angles_facts
    angles_facts = "The angles of this triangle are " + angles.join(",")
    if right_triangle?
      angles_facts += "\nThis triangle is also a right triangle!"
    end
    angles_facts
  end

  def recite_facts
    puts type_fact
    puts angles_facts
    puts
  end

  def calculate_angles
    [radians_to_degrees(angle_from_sides(side1, side2, side3)),
     radians_to_degrees(angle_from_sides(side2, side1, side3)),
     radians_to_degrees(angle_from_sides(side3, side1, side2))]
  end

  def angle_from_sides(a, b, c)
    Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
  [7, 7, 10],
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
