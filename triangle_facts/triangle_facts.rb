class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def is_equilateral?
    (side1 == side2) && (side2 == side3)
  end

  def is_isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def is_scalene?
    true unless is_equilateral? || is_isosceles?
  end

  def recite_facts
    print "This triangle: #{ self.object_id }, is "
    puts "equilateral!" if is_equilateral?
    puts "isosceles! Also, that word is hard to type." if is_isosceles?
    puts "scalene and mathematically boring." if is_scalene?
    puts "The angles of this triangle are #{ angles_from_sides.join(', ') }"
    puts "This triangle is also a right triangle!" if angles_from_sides.include? 90
    puts ""
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  private

  def angles_from_sides
    positions = [[side3, side2, side1],
                 [side1, side3, side2],
                 [side1, side2, side3]]
    angle_a, angle_b, angle_c = [0, 0, 0]
    angles = [angle_a, angle_b, angle_c]

    positions.each_with_index do |position, index|
      angles[index] = law_of_cosines(position)
    end
    angles
  end

  def law_of_cosines(sides)
    radians_to_degrees(Math.acos((sides[0]**2 + sides[1]**2 - sides[2]**2) / (2.0 * sides[0] * sides[1])))
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
  print "Let's change side 1 to 4in ... "
  tri.side1 = 4
  tri.recite_facts
end
