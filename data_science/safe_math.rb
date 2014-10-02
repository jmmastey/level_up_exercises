
module SafeMath
  def self.divide(x, y)
    return 0 if y == 0
    x.to_f / y.to_f
  end
end
