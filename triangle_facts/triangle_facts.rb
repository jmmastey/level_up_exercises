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

  def angle_from_sides(side)
    angle = law_of_cosines(side)
    radians_to_degrees(Math.acos(angle))
  end

  def calculate_angles
    ('a'..'c').to_a.map { |side| angle_from_sides(side) }
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def law_of_cosines(side)
    case side.to_sym
      when :a
        (side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3)
      when :b
        (side1**2 + side3**2 - side2**2) / (2.0 * side1 * side3)
      when :c
        (side1**2 + side2**2 - side3**2) / (2.0 * side1 * side2)
    end
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
