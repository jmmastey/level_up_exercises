class CalculateAngles

  def initialize(side_a, side_b, side_c)
    @side_a = side_a
    @side_b = side_b
    @side_c = side_c
  end

  def radians_to_degrees(radians)
    (radians * 180 / Math::PI).round
  end

  def calculate
    results = []
    (0..2).each do |index|
      sides = [@side_a, @side_b, @side_c]
      # This is a lambda that allows you to delete a value from an array
      # using index while retaining order. This is key because, normally if you
      # want to delete an array that is [5,5,5] and only want to delete one of the
      # 5 values you will end up with an empty array, this fixes that.
      # Svajone out
      # PS I am not testing this.
      subtract = lambda do |minuend, subtrahend|
        subtrahend.each.with_object(minuend) do |del|
          minuend.delete_at(minuend.index(del))
        end
      end
      x = sides[index]
      s = subtract.call sides, [x]
      y = s[0]
      z = s[1]
      results << radians_to_degrees(calculate_radians(x, y, z))
    end
    results
  end

  def calculate_radians(x, y, z)
		Math.acos((y**2 + z**2 - x**2) / (2.0 * y * z))
  end

end
