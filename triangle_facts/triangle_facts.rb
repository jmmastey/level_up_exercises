# Killer facts about triangles AWW YEAH
class Triangle
  def initialize(side_1, side_2, side_3)
    @side_1 = side_1
    @side_2 = side_2
    @side_3 = side_3
  end

  def radians_to_degrees(radians)
    (radians * 180 / Math::PI).round
  end

  def angle_1
    numerator = @side_2**2 + @side_3**2 - @side_1**2
    denominator = 2.0 * @side_2 * @side_3
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def angle_2
    numerator = @side_1**2 + @side_3**2 - @side_2**2
    denominator = 2.0 * @side_1 * @side_3
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def angle_3
    numerator = @side_1**2 + @side_2**2 - @side_3**2
    denominator = 2.0 * @side_1 * @side_2
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def equilateral?
    [side_1, side_2, side_3].uniq.length == 1
  end

  def isosceles?
    [side_1, side_2, side_3].uniq.length == 2
  end

  def scalene?
    [side_1, side_2, side_3].uniq.length == 3
  end

  def right?
    [angle_1, angle_2, angle_3].include?(90)
  end

  def recite_facts
    print_equilateral if equilateral?
    print_isosceles if isosceles?
    print_scalene if scalene?
    print_angles
    print_right if right?
    puts ""
  end

  def print_equilateral
    puts "This triangle is equilateral!"
  end

  def print_isosceles
    puts "This triangle is isosceles! Also, that word is hard to type."
  end

  def print_scalene
    puts "This triangle is scalene and mathematically boring."
  end

  def print_angles
    puts "The angles of this triangle are #{angle_1}, #{angle_2}, #{angle_3}"
  end

  def print_right
    puts "This triangle is also a right triangle!"
  end

  protected

  attr_reader :side_1, :side_2, :side_3
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |triangle|
  tri = Triangle.new(*triangle)
  tri.recite_facts
end
