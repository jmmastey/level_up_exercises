class Triangle
  attr_reader :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def recite_facts
    "This triangle is equilateral!" if equilateral?
    puts "This triangle is isosceles! Also, that word is hard to type." if isosceles?
    puts "This triangle is scalene and mathematically boring." if scalene?

    angles = calculate_angles(@side1, @side2, @side3)
    puts "The angles of this triangle are " + angles.join(",")

    puts "This triangle is also a right triangle!" if angles.include? 90  
  end

  private

  def calculate_angles(side_a, side_b, side_c)
    angle_a = radians_to_degrees(Math.acos((side_b**2 + side_c**2 - side_a**2) /
                                           (2.0 * side_b * side_c)))

    angle_b = radians_to_degrees(Math.acos((side_a**2 + side_c**2 - side_b**2) /
                                           (2.0 * side_a * side_c)))

    angle_c = radians_to_degrees(Math.acos((side_a**2 + side_b**2 - side_c**2) /
                                           (2.0 * side_a * side_b)))

    [angle_a, angle_b, angle_c]    
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def equilateral?
    @side1 == @side2 && @side2 == @side3 ? true : false
  end

  def isosceles?
    [@side1, @side2, @side3].uniq.length == 2 ? true : false
  end

  def scalene?
    equilateral? || isosceles? ? false : true
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
  [10, 12, 10]
]
triangles.each { |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
}
