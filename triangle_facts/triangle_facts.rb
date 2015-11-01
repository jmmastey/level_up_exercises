# Killer facts about triangles AWW YEAH
class Triangle
	attr_accessor :side1,:side2,:side3

	def initialize(side1, side2, side3)
		@side1 = side1
		@side2 = side2
		@side3 = side3
	end

	def equilateral
		return side1 == side2 && side2 == side3
	end

	def isosceles
		return [side1,side2,side3].uniq.length == 2
	end

	def scalene
		return false if (equilateral || isosceles)
		true
	end

	def recite_facts
		puts triangle_type

		puts prettify_angles

		puts right_triagle
	end

	def calculate_angles
		angleA = radians_to_degrees(Math.acos((@side2**2 + @side3**2 - @side1**2) / (2.0 * @side2 * @side3)))
		angleB = radians_to_degrees(Math.acos((@side1**2 + @side3**2 - @side2**2) / (2.0 * @side1 * @side3)))
		angleC = radians_to_degrees(Math.acos((@side1**2 + @side2**2 - @side3**2) / (2.0 * @side1 * @side2)))

		return [angleA, angleB, angleC]
	end

	def radians_to_degrees(rads)
		return (rads * 180 / Math::PI).round
	end

	def prettify_angles
		return "The angles of this triangle are #{calculate_angles.join(",")}"
	end

	def right_triagle
		return "This triangle is also a right triangle!" if calculate_angles.include?(90)
	end

	def triangle_type
		if equilateral
			'This triangle is equilateral!'
		elsif isosceles
			'This triangle is isosceles! Also, that word is hard to type.'
		else # scalene
			'This triangle is scalene and mathematically boring.'
		end
	end

end

triangles = [[5,5,5],
						 [5,12,13]]

triangles.each do |sides|
	tri = Triangle.new(*sides)
	tri.recite_facts
end
