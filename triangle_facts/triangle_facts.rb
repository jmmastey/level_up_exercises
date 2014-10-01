# Classify and display information about triangles, based on knowing sides.
class Triangle
  attr_accessor :sides, :angles

  def initialize(side1, side2, side3)
    @sides = side1, side2, side3

    @angles = calculate_angles
  end

  def triangle_type
    case sides.uniq.length
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
    a, b, c = sides

    angle_d = radians_to_degrees(
                Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)),
              )
    angle_e = radians_to_degrees(
                Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)),
              )
    angle_f = radians_to_degrees(
                Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)),
              )

    [angle_d, angle_e, angle_f]
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
