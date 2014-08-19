class Triangle
    attr_reader :side1,:side2,:side3

	def initialize(side1,side2,side3)
		@side1,@side2,@side3 = side1,side2,side3
	end

	def recite_facts
		puts 'This triangle is equilateral!' if is_equilateral
		puts 'This triangle is isosceles! Also, that word is hard to type.' if is_isosceles
		puts 'This triangle is scalene and mathematically boring.' if is_scalene

		angles = calculate_angles(@side1,@side2,@side3)
		puts 'The angles of this triangle are ' + angles.join(',')

		puts 'This triangle is also a right triangle!' if angles.include? 90
		puts ''
    end

    private

	def calculate_angles(a,b,c)
		angleA = radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c)))
		angleB = radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c)))
		angleC = radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))

		return [angleA, angleB, angleC]
	end

	def radians_to_degrees(rads)
		return (rads * 180 / Math::PI).round
    end

    def is_equilateral()
		if (@side1 == @side2 && @side2 == @side3)
            true
        else
            false
        end
	end

	def is_isosceles()
		if ([@side1,@side2,@side3].uniq.length == 2)
            true
        else
            false
        end
	end

	def is_scalene()
        if ! (is_equilateral || is_isosceles)
            true 
        else
            false 
        end
    end
end


triangles = [
	[5,5,5],
	[5,12,13],
    [10,12,10]
]
triangles.each { |sides|
	tri = Triangle.new(*sides)
	tri.recite_facts
}
