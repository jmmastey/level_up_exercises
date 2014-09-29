# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    self.side1 = side1
    self.side2 = side2
    self.side3 = side3
  end

  def equilateral?
    [side1, side2, side3].uniq.length == 1
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    [side1, side2, side3].uniq.length == 3
  end

  def recite_facts
    if equilateral?
      puts "This triangle is equilateral!"
    elsif isosceles?
      puts "This triangle is isosceles! Also, that word is hard to type."
    elsif scalene?
      puts "This triangle is scalene and mathematically boring."
    end
    angles = calculate_angles(side1, side2, side3)
    puts "The angles of this triangle are #{angles.join(",")}"
    puts "This triangle is also a right triangle!" if angles.include?(90)
  end

  def calculate_angles(side1, side2, side3)
    [calculate_opposing_angle(side1, side2, side3),
     calculate_opposing_angle(side2, side1, side3),
     calculate_opposing_angle(side3, side1, side2)]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def calculate_opposing_angle(opposing_side, other_side1, other_side2)
    numerator = other_side1**2 + other_side2**2 - opposing_side**2
    denomenator = 2.0 * other_side1 * other_side2
    radians_to_degrees(Math.acos(numerator / denomenator))
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
