# Killer facts about triangles AWW YEAH
class Triangle
	attr_accessor :side1,:side2,:side3

	def initialize(sides)
		@side1 = side1
    @side2 = side2
    @side3 = side3
	end

  def sides
    [@side1, @side2, @side3]
  end
	def equilateral()
	  side1 == side2 && side2 == side3
	end

	def isosceles()
		[side1, side2, side3].uniq.length == 2
	end

	def scalene()
		!(equilateral || isosceles)
	end

	def recite_facts
    if(equilateral)
      puts 'This triangle is equilateral!'
    elsif(isosceles)
      puts 'This triangle is isosceles! Also, that word is hard to type.'
    else
      puts 'This triangle is scalene and mathematically boring.' 
    end

		angles = self.calculate_angles(side1,side2,side3)
		puts 'The angles of this triangle are ' + angles.join(',')

		puts 'This triangle is also a right triangle!' if angles.include? 90
	end

	def calculate_angles(a,b,c)
		angleA = calculate_angle(a,b) 
		angleB = calculate_angle(b,c) 
		angleC = calculate_angle(c,a) 

		return [angleA, angleB, angleC]
	end

  def calculate_angle(side1, side2)
    radians_to_degrees(Math.cos((side1**2 + side2**2 - 
      (sides-[side1, side2])**2) / (2.0 * side1 * side2))) 
  end

	def radians_to_degrees(rads)
		(rads * 180 / Math::PI).round
	end
end


triangles = [
	[5,5,5],
	[5,12,13],
]
triangles.each { |sides|
	tri = Triangle.new(*sides)
	tri.recite_facts
}
