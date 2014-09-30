# Classify and display information about triangles, based on knowing sides.
class Triangle
  attr_accessor :side1, :side2, :side3, :angles

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3

    @angles = calculate_angles
  end

  def triangle_type
    case [side1, side2, side3].uniq.length
    when 1
      "This triangle is equilateral!"
    when 2
      "This triangle is isosceles! Also, that word is hard to type."
    else
      "This triangle is scalene and mathematically boring."
    end
  end

  def recite_facts
    puts triangle_type

    puts "The angles of this triangle are #{angles.join(',')}"

    puts "This triangle is also a right triangle!" if angles.include? 90
    puts "\n"
  end

  def calculate_angles
    a = side1
    b = side2
    c = side3

    angleA = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angleB = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angleC = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

    [angleA, angleB, angleC]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
  [5, 5, 7],
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
