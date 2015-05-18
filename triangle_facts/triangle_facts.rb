# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral
    return true if side1 == side2 && side2 == side3
    puts 'This triangle is equilateral!'
  end

  def isosceles
    return true if [side1, side2, side3].uniq.length == 2
    puts 'This triangle is isosceles! Also, that word is hard to type.'
  end

  def scalene
    return false if equilateral || isosceles == false
    puts 'This triangle is scalene and mathematically boring.'
  end

  def recite_facts
    equilateral

    isosceles

    scalene

    angles = calculate_angles(side1, side2, side3)

    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90

    puts ''
  end

  def calculate_angelsa(a, b, c)
    radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
  end

  def calculate_angelsb(a, b, c)
    radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
  end

  def calculate_angelsc(a, b, c)
    radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))
  end

  def calculate_angles(a, b, c)
    [calculate_angelsa(a, b, c), calculate_angelsb(a, b, c),
     calculate_angelsc(a, b, c)]
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
