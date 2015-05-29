# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1,:side2,:side3
  MESSAGES = {
               :equilateral =>  "This triangle is equilateral!", 
               :isosceles   =>  "This triangle is isosceles! \
                                 Also, that word is hard to type.",
               :scalene     =>  "This triangle is scalene and mathematically \
                                  boring."
  }

  def initialize(side1,side2,side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    return side1 == side2 && side2 == side3
  end

  def isosceles?
    return [side1,side2,side3].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def recite_facts
    
    puts MESSAGES[type]

    angles = self.calculate_angles(side1,side2,side3)

    puts "The angles of this triangle are #{angles.join(',')}"
    puts 'This triangle is also a right triangle!' if angles.include?(90)
    puts ''
  end

  def type
    return :equilateral if equilateral?
    return :isoceles    if isosceles?
    return :scalene
  end

  def calculate_angles(a,b,c)
    sides = [a, b, c]
    angles = []
    (0..2).each do |i|
      # swap element i with the first element
      sides[0], sides[i] = sides[i], sides[0]
      # get ith angle
      angles << calculate_angle(*sides)
    end
    angles
  end
  
  def calculate_angle(a, b, c)
    return radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
  end

  
  def radians_to_degrees(rads)
    return (rads * 180 / Math::PI).round
  end
end


triangles = [[5, 5, 5], [5,12,13]]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
