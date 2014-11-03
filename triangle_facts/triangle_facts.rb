# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def equilateral?
    (side1 == side2) && (side2 == side3)
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    ! (equilateral? || isosceles?)
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equilateral?
    puts 'This triangle is isosceles, which is hard to type.' if isosceles?
    puts 'This triangle is scalene and mathematically boring.' if scalene?
    angles = calculate_angles(side1, side2, side3)
    puts "The angles of this triangle are #{angles.join(',')}"
    puts "This triangle is also a right triangle! \n \n" if angles.include? 90
  end

  def calculate_angles(a, b, c)
    anglea = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angleb = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    anglec = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))
    [anglea, angleb, anglec]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
