class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def equilateral
     side1 == side2 && side2 == side3
  end

  def isosceles
    [side1, side2, side3].uniq.length == 2
  end

  def scalene
    side1 != side2 && side2 != side3
  end


  def recite_facts
    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is equilateral!' if equilateral
    puts 'This triangle is isosceles!' if isosceles
    puts 'This triangle is scalene!' if scalene

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    ang_a = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    ang_b = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    ang_c = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

    [ang_a, ang_b, ang_c]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13],
  [6, 6, 10],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
