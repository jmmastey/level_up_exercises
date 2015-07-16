class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
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

  def recite_facts
    type =
      if equilateral?
        'This triangle is equilateral!'        
      elsif isosceles?
        'This triangle is isosceles! Also, that word is hard to type.'
      elsif scalene?
         'This triangle is scalene and mathematically boring.'
      end 
    puts type

    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    rad_a = Math.acos((b ** 2 + c ** 2 - a ** 2) / (2.0 * b * c))
    angle_a = radians_to_degrees(rad_a)
    
    rad_b = Math.acos((a ** 2 + c ** 2 - b ** 2) / (2.0 * a * c))
    angle_b = angle_b = radians_to_degrees(rad_b)
    
    rad_c = Math.acos((a ** 2 + b ** 2 - c ** 2) / (2.0 * a * b))
    angle_c = radians_to_degrees(rad_c)

    [angle_a, angle_b, angle_c]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end


triangles = [
  [5, 5, 5],
  [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
