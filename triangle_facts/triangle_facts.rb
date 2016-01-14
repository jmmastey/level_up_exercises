# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def facts
    puts "\nFacts of a triangle with sides #{side1}, #{side2}, #{side3}"
    triangle_type_facts
    angle_facts
    puts "\n"
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def triangle_type
    return :equilateral if equilateral?
    return :isosceles if isosceles?
    :scalene
  end

  def triangle_type_facts
    case triangle_type
      when :equilateral then puts 'This triangle is equilateral!'
      when :isosceles then puts 'This triangle is isosceles!
                               Also, that word is hard to type.'
      when :scalene then puts 'This triangle is scalene and mathematically
                               boring.'
    end
  end

  def angle_facts
    angles = calculate_angles
    puts 'The angles of this triangle are ' << angles.join(',')
    puts 'This triangle is also a right triangle!' if (angles.include? 90)
  end

  private def calculate_angles
    angle_a = single_angle(side1, side2, side3)
    angle_b = single_angle(side2, side1, side3)
    angle_c = single_angle(side3, side1, side2)

    [angle_a, angle_b, angle_c]
  end

  private def single_angle(angle_side, other_side_1, other_side_2)
    numerator = (other_side_1**2 + other_side_2**2 - angle_side**2)
    denominator = (2.0 * other_side_1 * other_side_2)
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  private def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.facts
end
