class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
    @type = type_of_triangle
  end

  def type_of_triangle
    case
      when equilateral? then :equilateral
      when isosceles? then :isosceles
      when scalene? then :scalene
    end
  end

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
    [angle1, angle2, angle3].include?(90)
  end

  def print_angles
    puts "The angles of this triangle are #{angle1}, #{angle2}, #{angle3}"
  end

  def angle1
    numerator = @side2**2 + @side3**2 - @side1**2
    denominator = 2.0 * @side2 * @side3
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def angle2
    numerator = @side1**2 + @side3**2 - @side2**2
    denominator = 2.0 * @side1 * @side3
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def angle3
    numerator = @side1**2 + @side2**2 - @side3**2
    denominator = 2.0 * @side1 * @side2
    radians_to_degrees(Math.acos(numerator / denominator))
  end

  def which_triangle
    output = {
      equilateral: 'This triangle is equilateral!',
      isosceles: 'This triangle is isosceles! Also, that word is hard to type.',
      scalene: 'This triangle is scalene and mathematically boring.',
    }
    output[@type]
  end

  def recite_facts
    puts which_triangle
    puts print_angles
    puts 'This triangle is also aright triangle!' if right?
    puts ''
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
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
