# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral
    side1 == side2 && side2 == side3
  end

  def isosceles
    [side1, side2, side3].uniq.length == 2
  end

  def scalene
    if equilateral || isosceles
      false
    else
      true
    end
  end

  def triangle_type
    return :equilateral if equilateral
    return :isosceles if isosceles
    :scalene
  end

  def triangle_type_facts(triangle_type_name)
    case triangle_type_name
      when :equilateral then puts 'This triangle is equilateral!'
      when :isosceles then puts 'This triangle is isosceles!
                               Also, that word is hard to type.'
      when :scalene then puts 'This triangle is scalene and mathematically
                               boring.'
    end
  end

  def recite_facts
    
    triangle_type_facts(triangle_type)

    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def single_angle(angle_side, other_side_1, other_side_2)
    step_1 = (other_side_1**2 + other_side_2**2 - angle_side**2)
    step_2 = step_1 / (2.0 * other_side_1 * other_side_2)
    radians_to_degrees(Math.acos(step_2))
  end

  def calculate_angles(a, b, c)
    angle_a = single_angle(a, b, c)
    angle_b = single_angle(b, a, c)
    angle_c = single_angle(c, a, b)

    [angle_a, angle_b, angle_c]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5,  5],
  [5, 12, 13],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
