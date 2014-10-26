# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def num_unique_sides
    [side1, side2, side3].uniq.length
  end

  def equilateral?
    num_unique_sides == 1
  end

  def isosceles?
    num_unique_sides == 2
  end

  def scalene?
    num_unique_sides == 3
  end

  def recite_facts
    recite_type_facts
    recite_angle_facts
  end

  def recite_type_facts
    puts 'This triangle is equilateral!' if equilateral?
    puts 'This triangle is isosceles! Also, that word is hard to type.' \
      if isosceles?
    puts 'This triangle is scalene and mathematically boring.' if scalene?    
  end

  def recite_angle_facts
    angles = calculate_angles(side1, side2, side3)

    puts 'The angles of this triangle are ' + angles.join(',')
    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    angle_a = calculate_angle_from_vertices(a, b, c)
    angle_b = calculate_angle_from_vertices(b, a, c)
    angle_c = calculate_angle_from_vertices(c, b, a)

    [angle_a, angle_b, angle_c]
  end

  def calculate_angle_from_vertices(opposite, adjacent_a, adjacent_b)
    divident  = adjacent_a**2 + adjacent_b**2 - opposite**2
    divisor   = 2.0 * adjacent_a * adjacent_b
    cos_theta = divident / divisor
    radians   = Math.acos(cos_theta)
    radians_to_degrees(radians)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

