# This a class to define a
# triangle with three sides
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

  def scalene?
    if !(equilateral? || isosceles?)
      true
    else
      false
    end
  end

  def right_triangle?
    angles.include? 90
  end

  def type_statement
    return 'This triangle is equilateral!' if equilateral?
    return 'This triangle is isosceles!' if isosceles?
    return 'This triangle is scalene!' if scalene?
  end

  def recite_facts
    puts type_statement
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if right_triangle?
    puts ''
  end

  def angles
    cos_a = cosine(adjacent1: @side2, adjacent2: @side3, opposite: @side1)
    cos_b = cosine(adjacent1: @side1, adjacent2: @side3, opposite: @side2)
    cos_c = cosine(adjacent1: @side1, adjacent2: @side2, opposite: @side3)

    angle_a = radians_to_degrees(Math.acos(cos_a))
    angle_b = radians_to_degrees(Math.acos(cos_b))
    angle_c = radians_to_degrees(Math.acos(cos_c))

    [angle_a, angle_b, angle_c]
  end

  def cosine(sides)
    a = sides[:adjacent1]
    b = sides[:adjacent2]
    c = sides[:opposite]
    (a**2 + b**2 - c**2) / (2.0 * a * b)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
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
