# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :sides

  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3].sort
    fail 'This is an invalid Triangle, Man!?!' unless valid_triangle?
    @type = type
  end

  def type
    case @sides.uniq.size
    when 1 then :equilateral
    when 2 then :isosceles
    else :scalene
    end
  end

  def valid_triangle?
    @sides.min > 0 && @sides[0] + @sides[1] > @sides[2]
  end

  def which
    output = {
      equilateral: 'This triangle is equilateral!',
      isosceles: 'This triangle is isosceles! Also, that word is hard to type.',
      scalene: 'This triangle is scalene and mathematically boring.'
    }
    output[@type]
  end

  def recite_facts
    puts "#{@sides}"
    puts which
    angles = calculate_angles(@sides[0], @sides[1], @sides[2])
    puts 'The angles of this triangle are ' + angles.join(',')
    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    [calculate_angle(a, b, c),
     calculate_angle(b, c, a),
     calculate_angle(c, a, b)
    ]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def calculate_angle(a, b, c)
    num = (b**2 + c**2 - a**2)
    den = (2.0 * b * c)
    radians_to_degrees(Math.acos(num / den))
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13]
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
