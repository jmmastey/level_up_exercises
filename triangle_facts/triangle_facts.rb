# Killer facts about triangles AWW YEAH
class Triangle
  attr_reader :side1, :side2, :side3

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
    !(equilateral? || isosceles?)
  end

  def recite_facts
    puts side_facts
    puts angle_facts
    puts 
  end

  def side_facts
    return 'This triangle is equilateral!' if equilateral?
    return "This triangle is isosceles! "\
           "Also, that word is hard to type." if isosceles?
    return 'This triangle is scalene and mathematically boring.' if scalene?
  end

  def angle_facts
    angles = calculate_angles(side1, side2, side3)
    message = "The angles of this triangle are #{angles.join(',')}"
    message << "\nThis triangle is also a right triangle!" if angles.include? 90
    message
  end

  def calculate_angles(a, b, c)
    angle_a = calculate_angle(a, b, c)
    angle_b = calculate_angle(b, a, c)
    angle_c = calculate_angle(c, a, b)

    [angle_a, angle_b, angle_c]
  end

  # Uses the law of cosines to calculate angle opposite of 'side'
  # given three side lengths
  def calculate_angle(side, other1, other2)
    radians_to_degrees(Math.acos((other1**2 + other2**2 - side**2) /
                                 (2.0 * other1 * other2)))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],             # equilateral triangle
  [5, 12, 13],           # scalene triangle
  [2, 2, Math.sqrt(2) * 2] # isosceles right triangle
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
