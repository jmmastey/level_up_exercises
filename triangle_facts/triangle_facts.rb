class Triangle
  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
    @angles = calculate_angles(@side1, @side2, @side3)
  end

  def isosceles?
    [@side1, @side2, @side3].uniq.length == 2
  end

  def equilateral?
    [@side1, @side2, @side3].uniq.length == 2
  end

  def recite_facts
    recite_sides
    recite_angles
  end

  def recite_angles
    puts 'The angles of this triangle are ' + @angles.join(', ')
    puts 'This triangle is also a right triangle!' if @angles.include? 90
    puts "\n"
  end

  def recite_sides
    if equilateral?
      puts 'This triangle is equilateral'
    elsif isosceles?
      puts 'This triangle is isosceles! Also, that word is hard to type.'
    else
      puts 'This triangle is scalene and mathematically boring.'
    end
  end

  def calculate_angles(a, b, c)
    angle_a = angle_math(b, c, a)
    angle_b = angle_math(a, c, b)
    angle_c = angle_math(a, b, c)
    [angle_a,  angle_b,  angle_c]
  end

  def angle_math(first, second, third)
    step_1 = (first**2 + second**2 - third**2) / (2.0 * first * second)
    step_2 = Math.acos(step_1)
    radians_to_degrees(step_2)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end
triangles = [
  [5, 5, 5],
  [5, 12, 13],
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
