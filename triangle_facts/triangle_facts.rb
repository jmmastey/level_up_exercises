# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side_1, :side_2, :side_3

  def initialize(side_1, side_2, side_3)
    @side_1, @side_2, @side_3 = side_1, side_2, side_3
  end

  def equilateral?
    side_1 == side_2 && side_2 == side_3
  end

  def isosceles?
    [side_1, side_2, side_3].uniq.length == 2
  end

  def scalene?
    if equilateral? || isosceles?
      false
    else
      true
    end
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equilateral?

    puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles?

    puts 'This triangle is scalene and mathematically boring.' if scalene?

    angles = self.calculate_angles(side_1, side_2, side_3)

    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90

    puts ''
  end

  def calculate_angles(side_1, side_2, side_3)
    angle_1 = radians_to_degrees(Math.acos((side_2**2 + side_3**2 - side_1**2) / (2.0 * side_2 * side_3)))

    angle_2 = radians_to_degrees(Math.acos((side_1**2 + side_3**2 - side_2**2) / (2.0 * side_1 * side_3)))

    angle_3 = radians_to_degrees(Math.acos((side_1**2 + side_2**2 - side_3**2) / (2.0 * side_1 * side_2)))

    [angle_1, angle_2, angle_3]
  end

  def radians_to_degrees(radians)
    (radians * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13]
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
