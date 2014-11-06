class ChiSquareCalc

  def self.calculate(groupone_hash, grouptwo_hash)
    a = groupone_hash[:success].to_f
    b = groupone_hash[:totalno].to_f
    c = grouptwo_hash[:success].to_f
    d = grouptwo_hash[:totalno].to_f
    calc_chisquare(a,b,c,d)
  end

  def self.calc_chisquare(*args)
    a,b,c,d = *args
    [a,b,c,d].each do |element|
      raise ArgumentError, "One or more arguments is negative" if element < 0
      raise ArgumentError, "One or more of the arguments passed is not a numeral" unless is_numeral?(element)
    end
    b = b-a
    d = d-c
    numerator_part1 = (a*d-b*c)**2
    numerator_part2 = a+b+c+d
    denominator = (a+b)*(c+d)*(b+d)*(a+c)
    chisquared_value = (numerator_part1*numerator_part2/denominator.to_f).round(2)
    puts "chi squared value #{chisquared_value}"
    chisquared_value
  end

  def self.is_numeral?(var)
    var.is_a? Numeric
  end

end
