# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(sides)
    @side1, @side2, @side3 = sides
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    equilateral? || scalene? ? false : true
  end

  def recite_facts
    puts type_message
    puts angle_message
  end

  def type_message
    if equilateral?
      'This triangle is equilateral!'
    elsif isosceles?
      'This triangle is isosceles! Also, that word is hard to type.'
    else
      'This triangle is scalene and mathematically boring.'
    end
  end

  def angle_message
    angles = calculate_angles(side1, side2, side3)

    msg = 'The angles of this triangle are ' + angles.join(',')
    msg += "\nThis triangle is also a right triangle!" if angles.include? 90
    msg + "\n\n"
  end

  def calculate_angles(a, b, c)
    angle_a = calculate_angle(a, b, c)
    angle_b = calculate_angle(b, c, a)
    angle_c = calculate_angle(c, a, b)

    [angle_a, angle_b, angle_c]
  end

  def calculate_angle(m, n, o)
    radians_to_degrees(Math.acos((n**2 + o**2 - m**2) / (2.0 * n * o)))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(sides)
  tri.recite_facts
end
