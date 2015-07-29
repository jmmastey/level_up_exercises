# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def recite_facts
    print_sides
    check_equilateral
    check_isosceles
    check_scalene
    angles = calculate_angles
    check_right(angles)
    print_angle(angles)
  end

  private

  def print_sides
    puts "This triangle has sides #{side1}, #{side2}, #{side3}"
  end

  def check_equilateral
    puts "This triangle is equilateral!" if equilateral?
  end

  def check_isosceles
    puts "This triangle is isosceles!" if isosceles?
  end

  def check_scalene
    puts "This triangle is scalene!\n" if scalene?
  end

  def check_right(angles)
    puts "This triangle is also a right triangle! \n" if angles.include? 90
  end

  def print_angle(angles)
    puts "The angles of this triangle are " + angles.join(', ') + "\n"
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def law_of_cosine(s1, s2, s3)
    (Math.acos((s1**2 + s2**2 - s3**2) / (2.0 * s1 * s2)))
  end

  def cosine_angles
    angle_a = law_of_cosine(side2, side3, side1)
    angle_b = law_of_cosine(side1, side3, side2)
    angle_c = law_of_cosine(side1, side2, side3)
    [angle_a, angle_b, angle_c]
  end

  def calculate_angles
    converted_angles = []
    triangle_angles = cosine_angles
    triangle_angles.each do |ang|
      converted_angles << radians_to_degrees(ang)
    end
    converted_angles
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    equilateral? || isosceles? ? false : true
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
  [6, 6, 10],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
