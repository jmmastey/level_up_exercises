# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1
  attr_accessor :side2
  attr_accessor :side3
  attr_accessor :angle_a
  attr_accessor :angle_b
  attr_accessor :angle_c

  protected :side1
  protected :side2
  protected :side3
  protected :angle_a
  protected :angle_b
  protected :angle_c

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
    calculate_angles
  end

  def angleize(a, b, c)
    (Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)) * (180 / Math::PI)).round
  end

  def calculate_angles
    @angle_a = angleize(@side2, @side3, @side1)
    @angle_b = angleize(@side1, @side3, @side2)
    @angle_c = angleize(@side1, @side2, @side3)
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

  def right?
    if (@angle_a || @angle_b || @angle_c) == 90
      true
    else
      false
    end
  end

  def recite_facts
    puts "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles! Also, that word is \
      hard to type." if isosceles?
    puts "This triangle is scalene and mathematically boring." if scalene?

    puts "The angles of this triangle are #{angle_a},#{angle_b},#{angle_c}"

    puts "This triangle is also a right triangle!" if right?
    puts ""
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
