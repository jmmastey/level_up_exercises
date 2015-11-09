# Killer facts about triangles AWW YEAH
class Triangle

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    @side1 == @side2 && @side2 == @side3
  end

  def isosceles?
    [@side1, @side2, @side3].uniq.length == 2
  end

  def scalene?
    !equilateral? && !isosceles?
  end

  def recite_facts
    case true
    when equilateral?
      puts "This triangle is equilateral!"
    when isosceles?
      puts "This triangle is isosceles! Also, that word is hard to type."
    when scalene?
      puts "This triangle is scalene and mathematically boring."
    end

    angles = calculate_angles(@side1, @side2, @side3)
    angles_prettified = angles.join(",")
    puts "The angles of this triangle are #{angles_prettified}"

    if angles.include? 90
      puts "This triangle is also a right triangle!"
    end
    puts ""
    angles_prettified
  end

  def calculate_angles(adjacent, opposite, hypotenuse)
    angleA = solve_for_angle((opposite**2 + hypotenuse**2 - adjacent**2) / (2.0 * opposite * hypotenuse))
    angleB = solve_for_angle((adjacent**2 + hypotenuse**2 - opposite**2) / (2.0 * adjacent * hypotenuse))
    angleC = solve_for_angle((adjacent**2 + opposite**2 - hypotenuse**2) / (2.0 * adjacent * opposite))

    [angleA, angleB, angleC]
  end
	
  attr_reader :side1, :side2, :side3
	
  protected
	
  attr_writer :side1, :side2, :side3
	
  private
	
  def solve_for_angle(distance)
    radians = Math.acos(distance)
    radians_to_degrees(radians)
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end