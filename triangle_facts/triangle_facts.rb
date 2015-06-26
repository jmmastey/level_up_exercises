# Killer facts about triangles AWW YEAH
class Triangle
	attr_accessor :side1, :side2, :side3

	def initialize(side1, side2, side3)
		@side1, @side2, @side3 = side1, side2, side3
	end

	def equilateral?
		side1 == side2 && side2 == side3
	end

	def isosceles?
		[side1, side2, side3].uniq.length == 2
	end

	def scalene?
		!( equilateral? || isosceles? )
	end

	def recite_type
		print "This triangle is "

		if isosceles?
			puts "isosceles! Also, that word is hard to type."
		elsif equilateral?
			puts "equilateral!"
		else
			puts "scalene and mathematically boring."
		end
	end

	def recite_angles
		angles = self.calculate_angles( side1, side2, side3 )
		puts "The angles of this triangle are #{ angles.join( ',' ) }"

		puts "This triangle is also a right triangle!" if angles.include? 90
		puts 
	end

	def recite_facts
		recite_type()
		recite_angles()
	end

	def calculate_angles(a, b, c)
		sides = [ 
			[b, c, a], 
			[a, c, b], 
			[a, b, c]
		]
		sides.map!{ |side|
			abc2 = ( side[0] ** 2 + side[1] ** 2 - side[2] ** 2 )
			2ab = ( 2.0 * side[0] * side[1] )

			radians_to_degrees( Math.acos( abc2 / 2ab ) )
		}
	end

	def radians_to_degrees(rads)
		( rads * 180 / Math::PI ).round
	end
end


triangles = [
	[5, 5, 5],
	[5, 12, 13],
]
triangles.each { |sides|
	tri = Triangle.new( *sides )
	tri.recite_facts()
}
