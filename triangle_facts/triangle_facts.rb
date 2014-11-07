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

  def scalene?
    (equilateral? || isosceles?) ? true : false
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equilateral?
    puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles?
    puts 'This triangle is scalene and mathematically boring.' if scalene?

    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    results = []
    [[b, c, a], [a, c, b], [a, b, c]].each do |combo|
      results << trig_function(combo[0], combo[1], combo[2])
    end
    results
  end

  private

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def trig_function(a, b, c)
    radians_to_degrees(Math.acos(
      (a**2 + b**2 - c**2) / (2.0 * a * b),
    ))
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
