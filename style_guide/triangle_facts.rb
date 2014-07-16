# facts about triangles

class Triangle

	attr_accessor :side1, :side2, :side3

	def initialize(side1, side2, side3)
		@side1 = side1
		@side2 = side2
		@side3 = side3
	end

	def equilateral
		side1 == side2 && side2 == side3
	end

	def isosceles
		[side1,side2,side3].uniq.length == 2
	end

	def scalene()
		!(equilateral || isosceles)
	end

	def recite_facts

		if equilateral
				puts "This triangle is equilateral!"
		elsif isosceles
				puts "This triangle is isosceles! Also, that word is hard to type."
		elsif scalene
				puts "This triangle is scalene and mathematically boring."
		end

		angles = self.calculate_angles(side1, side2, side3)

		puts "The angles of this triangle are #{angles.join(',')}"

		if angles.include?(90)
			puts "This triangle is also a right triangle!"
		end

		puts ""

	end

	def calculate_angles(a, b, c)

		a2 = a**2
		b2 = b**2
		c2 = c**2

		angleA = radians_to_degrees(Math.acos((b2 + c2 - a2) / (2.0 * b * c)))
		angleB = radians_to_degrees(Math.acos((a2 + c2 - b2) / (2.0 * a * c)))
		angleC = radians_to_degrees(Math.acos((a2 + b2 - c2) / (2.0 * a * b)))

		return [angleA, angleB, angleC]
	end

	def radians_to_degrees(rads)
		return (rads * 180 / Math::PI).round
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
