# Killer facts about triangles AWW YEAH
Triangle = Struct.new(:side_1, :side_2, :side_3) do

  def angles
    calculate_angles(side_1, side_2, side_3)
  end

  def equilateral?
    sides.uniq.length == 1
  end

  def isosceles?
    sides.uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def sides
    [side_1, side_2, side_3]
  end

  def right_triangle?
    angles.include?(90)
  end

  def to_s
    puts description
    puts 'The angles of this triangle are ' << angles.join(', ')
    puts 'This triangle is also a right triangle!' if right_triangle?
    puts ''
  end

  protected

  def calculate_angles(a, b, c)
    angle_a = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angle_b = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angle_c = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

    [angle_a, angle_b, angle_c]
  end

  def description
    if equilateral?
      'This triangle is equilateral!'
    elsif isosceles?
      'This triangle is isosceles! Also, that word is hard to type.'
    elsif scalene?
      'This triangle is scalene and mathematically boring.'
    end
  end

  def radians_to_degrees(radians)
    (radians * 180 / Math::PI).round
  end
end


triangles = [ [5,5,5], [5,12,13] ]
triangles.each do |sides|
  triangle = Triangle.new(*sides)
  triangle.to_s
end
