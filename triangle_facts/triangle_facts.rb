# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end
  
  def calculate_angles(a, b, c)  
    angle_a = radians_to_degrees(
      Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))
    )
    
    angle_b = radians_to_degrees(
      Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c))
    )
    
    angle_c = radians_to_degrees(
      Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
    )

    [angle_a, angle_b, angle_c]
  end

  def equilateral
    (side1 == side2) && (side2 == side3)
  end

  def isosceles
    [side1, side2, side3].uniq.length == 2
  end
  
  def recite_facts
    if equilateral
      puts 'This triangle is equilateral!'
    elsif isosceles
      puts 'This triangle is isosceles! Also, that word is hard to type.'
    elsif scalene
      puts 'This triangle is scalene and mathematically boring.'
    end
    
    angles = self.calculate_angles(side1, side2, side3)

    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end
  
  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end

  def scalene
    !equilateral && !isosceles
  end
end


triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |sides|
  triangle = Triangle.new(*sides)
  triangle.recite_facts
end
