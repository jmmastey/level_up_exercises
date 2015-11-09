# Killer facts about triangles AWW YEAH
class Triangle

	def initialize(side1,side2,side3)
		@side1 = side1
		@side2 = side2
		@side3 = side3
	end

	def equilateral()
		side1 == side2 && side2 == side3
	end

	def isosceles()
		[side1,side2,side3].uniq.length == 2
	end

	def scalene()
		if !equilateral && !isosceles
	    true
	  else
	    false
	  end
	end

	def recite_facts
		if equilateral
			puts "This triangle is equilateral!"
		elsif isosceles
			puts "This triangle is isosceles! Also, that word is hard to type." 
		elsif scalene 
			puts "This triangle is scalene and mathematically boring."
		end

		angles = self.calculate_angles(side1,side2,side3)
		angles_prettified = angles.join(",")
		puts "The angles of this triangle are #{angles_prettified}"

		if angles.include? 90
				puts "This triangle is also a right triangle!"
		end
		puts ""
	end

	def calculate_angles(a,b,c)
		angleA = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
		angleB = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
		angleC = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

		[angleA, angleB, angleC]
	end
	
	protected
	
	attr_accessor :side1
	attr_accessor :side2
	attr_accessor :side3
	
	private

	def radians_to_degrees(rads)
		(rads * 180 / Math::PI).round
	end
end


triangles = [
	[5,5,5],
	[5,12,13],
]
triangles.each do |sides|
	tri = Triangle.new(*sides)
	tri.recite_facts
end
