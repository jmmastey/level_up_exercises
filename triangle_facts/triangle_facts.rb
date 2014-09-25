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
    !(equilateral? || !isosceles?)
  end

  def recite_facts
    if equilateral?
      puts "This triangle is equilateral!"
    elsif isosceles?
      puts "This triangle is isosceles! Also, that word is hard to type."
    else
      puts "This triangle is scalene and mathematically boring."
    end

    angles = calculate_angles(side1, side2, side3)
    puts "The angles of this triangle are #{angles.join(",")}"

    puts "This triangle is also a right triangle!" if angles.include?(90)
  end

  def calculate_angles(a, b, c)
    [to_angle(a, b, c), to_angle(b, a, c), to_angle(c, a, b)]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def to_angle(angle_side, side_b, side_c)
    radians_to_degrees(Math.acos((side_b**2 + side_c**2 - angle_side**2) /
                       (2.0 * side_b * side_c)))
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
