# Killer facts about triangles AWW YEAH
class Triangle
  def initialize(side_1, side_2, side_3)
    @side_1 = side_1
    @side_2 = side_2
    @side_3 = side_3
    @angles = triangle_angles([@side_1, @side_2, @side_3])
  end

  def triangle_angles(sides)
    numerator = sides.inject(0.0) { |sum, side| sum + side**2 }
    denominator = sides.inject(1.0) { |product, side| product * side } * 2
    sides.map do |side|
      radians_to_degrees(Math.acos((numerator - 2 * side**2) / (denominator / side)))
    end
  end

  def radians_to_degrees(radians)
    (radians * 180 / Math::PI).round
  end

  def equilateral?
    @angles.uniq.length == 1
  end

  def isosceles?
    @angles.uniq.length == 2
  end

  def scalene?
    @angles.uniq.length == 3
  end

  def right?
    @angles.include?(90)
  end

  def recite_facts
    puts "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles! Also, that word is hard to type." if isosceles?
    puts "This triangle is scalene and mathematically boring." if scalene?
    puts "The angles of this triangle are: #{@angles}"
    puts "This triangle is also a right triangle!" if right?
    puts
  end

  protected

  attr_reader :side_1, :side_2, :side_3, :angles
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |triangle|
  tri = Triangle.new(*triangle)
  tri.recite_facts
end
