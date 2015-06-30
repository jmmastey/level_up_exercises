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
    ! (equilateral || isosceles)
  end

  def recite_facts
    recite_side_facts
    recite_angle_facts
    puts ''
  end

  def recite_side_facts
    puts 'This triangle is equilateral!' if equilateral
    if isosceles
      puts 'This triangle is isosceles! Also, that word is hard to type.'
    end
    puts 'This triangle is scalene and mathematically boring.' if scalene
  end

  def recite_angle_facts
    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
  end

  def calculate_angles(a, b, c)
    [calculate_angle_opposite_first_side(a, b, c),
     calculate_angle_opposite_first_side(b, a, c),
     calculate_angle_opposite_first_side(c, b, a),
    ]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def calculate_cos_opposite_first_side(first_side, second_side, third_side)
    numerator = first_side**2 + second_side**2 - third_side**2
    denominator = 2.0 * first_side * second_side
    numerator / denominator
  end

  def calculate_angle_opposite_first_side(first_side, second_side, third_side)
    cos = calculate_cos_opposite_first_side(first_side, second_side, third_side)
    radians_to_degrees(Math.acos(cos))
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
