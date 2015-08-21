# Killer facts about triangles AWW YEAH
class Triangle

	attr_accessor :side1, :side2, :side3
	attr_reader :angles

	def initialize(side1, side2, side3)
		@side1 	= side1
		@side2 	= side2
		@side3 	= side3
		@angles = calculate_angles(@side1, @side2, @side3)
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

	def right_angle?
		angles.include? 90
	end

	def recite_facts
		triangleFacts = "This triangle is equilateral!" if equilateral?
		triangleFacts = "This triangle is isosceles! Also, that word is hard to type." if isosceles?
		triangleFacts = "This triangle is scalene and mathematically boring." if scalene?
		puts triangleFacts

		puts "This triangle is also a right triangle!" if right_angle?
		puts "The angles of this triangle are #{ angles.join(",") }"
	end

	def calculate_angles(a, b, c)
		angleA = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
		angleB = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
		angleC = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

		[angleA, angleB, angleC]
	end

	def radians_to_degrees(rads)
		(rads * 180 / Math::PI).round
	end
end

triangles = [
	[5, 5, 5],
	[6, 6, 8],
	[5, 12, 13]
]

triangles.each { |sides|
	tri = Triangle.new(*sides)
	tri.recite_facts
}
