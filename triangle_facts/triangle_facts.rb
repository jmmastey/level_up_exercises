# Killer facts about triangles AWW YEAH
class Triangle
  def initialize(side_1, side_2, side_3)
    @side_1 = side_1
    @side_2 = side_2
    @side_3 = side_3
    @angles = triangle_angles(@side_1, @side_2, @side_3)
  end

  def triangle_angles(*sides) # Return array of the triangle's angles, in radians
    numerator = sides.inject(0.0) { |sum, side| sum + side**2 }
    denominator = sides.inject(1.0) { |product, side| product * side } * 2
    sides.map do |side|
      angles_in_radians = Math.acos((numerator - 2 * side**2) / (denominator / side))
      radians_to_degrees(angles_in_radians)
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
    puts print_triangle_type
    puts "The angles of this triangle are: #{@angles.join(', ')}"
    puts "This triangle is also a right triangle!" if right?
    puts
  end

  def print_triangle_type
    if equilateral?
      "This triangle is equilateral!"
    elsif isosceles?
      "This triangle is isosceles! Also, that word is hard to type."
    elsif scalene?
      "This triangle is scalene and mathematically boring."
    else
      "This is not a valid triangle."
    end
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |triangle|
  tri = Triangle.new(*triangle)
  tri.recite_facts
end
