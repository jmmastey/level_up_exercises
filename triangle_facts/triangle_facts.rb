# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(sides)
    @side1, @side2, @side3 = sides
  end

  def equilateral()
    return side1 == side2 && side2 == side3
  end

  def isosceles()
    return [side1,side2,side3].uniq.length == 2
  end

  def scalene()
    unless ! (equilateral || isosceles)
      false
    else
      true
    end
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equilateral
    puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles 
    puts 'This triangle is scalene and mathematically boring.' if scalene 

    angles = self.calculate_angles(side1,side2,side3)
    puts 'The angles of this triangle are ' + angles.join(',')

    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a,b,c)
    angleA = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
    angleB = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
    angleC = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

    return [angleA, angleB, angleC]
  end

  def radians_to_degrees(rads)
    return (rads * 180 / Math::PI).round
  end
end


triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(sides)
  tri.recite_facts
end
