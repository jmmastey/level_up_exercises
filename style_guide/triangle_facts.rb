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
    return 'This triangle is isosceles! Also, that word is hard to type.' if isosceles?
    return 'This triangle is scalene and mathematically boring.' if scalene?
  end

  def recite_facts
    puts type_statement
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if right_triangle?
    puts ''
  end

  def angles
    angleA = radians_to_degrees(Math.acos(cosine(@side2, @side3, @side1)))
    angleB = radians_to_degrees(Math.acos(cosine(@side1, @side3, @side2)))
    angleC = radians_to_degrees(Math.acos(cosine(@side1, @side2, @side3)))

    [angleA, angleB, angleC]
  end

  def cosine(a, b, c)
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
