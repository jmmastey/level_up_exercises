# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def recite_facts
    puts "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles! "\
    "Also, that word is hard to type." if isosceles?
    puts "This triangle is scalene and mathematically boring." if scalene?
    puts "The angles of this triangle are #{angles.join(',')}"
    puts "This triangle is also a right triangle!" if angles.include?(90)
    puts "\n"
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

  def angles
    [
      calculate_angle(side1, side2, side3),
      calculate_angle(side2, side3, side1),
      calculate_angle(side3, side2, side1),
    ]
  end

  def calculate_angle(sideA, sideB, sideC)
    rads = Math.acos((sideB**2 + sideC**2 - sideA**2) / (2.0 * sideB * sideC))
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
  [4, 3, 4],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
