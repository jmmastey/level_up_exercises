class NumberUtils
  attr_accessor :values, :i

  def initialize(i = 1_000)
    @values = {}
    @i = i
    do_it
  end

  def do_it
    1.upto(@i) do |i|
      @values[i] = get_values_for(i)
    end
  end

  def get_values_for(i)
    i2 = i
    v = []
    2.upto(i) do |n|
      while (i2 % n).zero?
        v << n
        i2 = i2 / n
      end
    end
    v
  end

  def get_values(i)
    raise 'Value too high!' unless i <= @i
    @values[i]
  end

  def all
    @values
  end
end


u = NumberUtils.new(100)
puts u.all
