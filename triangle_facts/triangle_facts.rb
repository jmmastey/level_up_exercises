# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def recite_facts
    triangle_type
    angles = calculate_angles(side1, side2, side3)
    puts "The angles of this triangle are #{ angles.join(',') }"
    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(side1, side2, side3)
    angle_a = radian_to_degree(side_to_radians(side2, side3, side1))
    angle_b = radian_to_degree(side_to_radians(side1, side3, side2))
    angle_c = radian_to_degree(side_to_radians(side1, side2, side3))

    [angle_a, angle_b, angle_c]
  end

  def radian_to_degree(rads)
    (rads * 180 / Math::PI).round
  end

  def side_to_radians(side2, side3, side1)
    Math.acos((side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3))
  end

  def triangle_type
    if equilateral?
      puts 'This triangle is equilateral!'
    elsif isosceles?
      puts 'This triangle is isosceles, which is hard to type.'
    else
      puts 'This triangle is scalene and mathematically boring.'
    end
  end
end

triangles =
    [[5, 5, 5],
     [5, 12, 13]]

triangles.each { |sides| Triangle.new(*sides).recite_facts }
