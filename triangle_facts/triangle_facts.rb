class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def recite_facts
    puts triangle_type
    puts 'The angles of this triangle are ' + calculate_angles.join(',')
    puts FACTS[:right] if right?
    puts ''
  end

  def triangle_type
    case
      when equilateral?
        FACTS[:equilateral]
      when isosceles?
        FACTS[:isosceles]
      when scalene?
        FACTS[:scalene]
      else
        FACTS[:unknown]
    end
  end

  private

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def right?
    angles = calculate_angles
    angles.include?(90)
  end

  def calculate_angles
    [angle_a, angle_b, angle_c]
  end

  def angle_a
    x = side2**2 + side3**2 - side1**2
    y = 2.0 * side2 * side3

    radians_to_degrees(angle_radians(x, y))
  end

  def angle_b
    x = side1**2 + side3**2 - side2**2
    y = 2.0 * side1 * side3

    radians_to_degrees(angle_radians(x, y))
  end

  def angle_c
    x = side1**2 + side2**2 - side3**2
    y = 2.0 * side1 * side2

    radians_to_degrees(angle_radians(x, y))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def angle_radians(x, y)
    Math.acos(x / y)
  end

  FACTS = {
    equilateral: 'This triangle is equilateral!',
    isosceles: 'This triangle is isosceles! Also, that word is hard to type.',
    scalene: 'This triangle is scalene and mathematically boring.',
    right: 'This triangle is also a right triangle!',
    unknown: 'Are you sure this is even a triangle?',
  }
end

#
triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
