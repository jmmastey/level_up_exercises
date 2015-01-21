# Killer facts about triangles AWW YEAH
#

require './calculate_angles.rb'

class Triangle
	attr_accessor :side_a,:side_b,:side_c

	def initialize(side_a,side_b,side_c)
		@side_a = side_a
    @side_b = side_b
    @side_c = side_c
	end

	def equilateral?
		@side_a == @side_b && @side_b == @side_c
	end

	def isosceles?
		[@side_a, @side_b, @side_c].uniq.length == 2
	end

	def scalene?
    equilateral? || isosceles?
	end

	def recite_facts
		angles = CalculateAngles.new(@side_a, @side_b, @side_c).calculate
		puts 'This triangle is equilateral!' if equilateral?
		puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles?
		puts 'This triangle is scalene and mathematically boring.' if scalene?
		puts 'The angles of this triangle are ' + angles.join(',')
		puts 'This triangle is also a right triangle!' if angles.include? 90
		puts ''
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
