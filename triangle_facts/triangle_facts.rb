# Killer facts about triangles AWW YEAH
class Triangle
  attr_reader :sides

  def initialize(*sides)
    @sides = sides[0, 3]
  end

  def recite_facts
    puts side_facts
    puts angle_facts + "\n\n"
  end

  private

  def type
    [:equilateral, :isosceles, :scalene].at(sides.uniq.size - 1)
  end

  def side_facts
    case type
    when :equilateral
      'This triangle is equilateral!'
    when :isosceles
      'This triangle is isosceles! Also, that word is hard to type.'
    when :scalene
      'This triangle is scalene and mathematically boring.'
    end
  end

  def angle_facts
    ["The angles of this triangle are #{angles.join(',')}",
     ('This triangle is also a right triangle!' if angles.include?(90)),
    ].compact.join("\n")
  end

  def angles
    permutations = (0..2).map { |i| sides.rotate(i) }
    permutations.map { |perm| calculate_angle(*perm) }
  end

  # Uses the law of cosines to calculate angle opposite of 'side'
  # given three side lengths
  def calculate_angle(side, first_adj_side, second_adj_side)
    rads = Math.acos((first_adj_side**2 + second_adj_side**2 - side**2) /
                     (2.0 * first_adj_side * second_adj_side))
    radians_to_degrees(rads)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],             # equilateral triangle
  [5, 12, 13],           # scalene triangle
  [2, 2, Math.sqrt(2) * 2] # isosceles right triangle
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
