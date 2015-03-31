class Triangle
  attr_accessor :side1,:side2,:side3

  def initialize(side1,side2,side3)
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

  def scalene
    !equilateral && !isosceles
  end

  def right
    angles.include? 90
  end

  def angles
    rads = radians #avoiding running the method 3 times

    angle1 = radians_to_degrees(rads[0])
    angle2 = radians_to_degrees(rads[1])
    angle3 = radians_to_degrees(rads[2])

    [angle1, angle2, angle3]
  end

  def radians
  [
    Math.acos((side2**2 + side3**2 - side1**2) / (2.0 * side2 * side3)),
    Math.acos((side1**2 + side3**2 - side2**2) / (2.0 * side1 * side3)),
    Math.acos((side1**2 + side2**2 - side3**2) / (2.0 * side1 * side2))
  ]
  end

  private
  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end
