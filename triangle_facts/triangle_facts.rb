# Killer facts about triangles AWW YEAH
class Triangle
  attr_reader :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1, @side2, @side3 = side1, side2, side3
  end

  def recite_facts
    puts type_facts
    puts angle_facts + "\n\n"
  end

  def type_facts
    case triangle_type
      when :equilateral
        'This triangle is equilateral!'
      when :isosceles
        'This triangle is isosceles! Also, that word is hard to type.'
      else 'This triangle is scalene and mathematically boring.'
    end
  end

  def angle_facts
    angles = calculate_angles
    "The angles of this triangle are #{angles.join(',')}" \
      "#{"\nThis triangle is also a right triangle!" if angles.include? 90}"
  end

  def triangle_type
    return :equilateral if side1 == side2 && side2 == side3
    return :isosceles   if [side1, side2, side3].uniq.length == 2
    :scalene
  end

  def calculate_angles
    angle_1 = rad_to_deg(Math.acos((side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3)))
    angle_2 = rad_to_deg(Math.acos((side1**2 + side3**2 - side2**2) / (2.0 * side1 * side3)))
    angle_3 = rad_to_deg(Math.acos((side1**2 + side2**2 - side3**2) / (2.0 * side1 * side2)))
    [angle_1, angle_2, angle_3]
  end

  def rad_to_deg(rads)
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
