require_relative '../stat_calculator'

describe Stat_Calculator do

  describe "#standard_error" do
    it "should return standard error as sqrt(pq/n)" do
      expect(Stat_Calculator.standard_error(0.5, 1)).to eql 0.5
    end

    it "should round to 3 decimal places" do
      expect(Stat_Calculator.standard_error(0.2, 1000).to_s).to match /\d+\.\d{3}/
    end

    it "should raise an error for divide by zero" do
      expect{Stat_Calculator.standard_error(0.5, 0)}.to raise_error(ArgumentError, "Sample size must be greater than 0")
    end

    it "should raise an error for negative sample size" do
      expect{Stat_Calculator.standard_error(0.5, -1)}.to raise_error(ArgumentError, "Sample size must be greater than 0")
    end

    it "should raise an error if probability is not between 0 and 1" do
      expect{Stat_Calculator.standard_error(2, 100)}.to raise_error(ArgumentError, "Probability must be between 0 and 1")
      expect{Stat_Calculator.standard_error(-1, 100)}.to raise_error(ArgumentError, "Probability must be between 0 and 1")
    end
  end

  describe "#chi_square" do
    it "should return chi_square value as ((ad-bc)^2 * (a+b+c+d))/((a+b)*(c+d)*(b+d)*(a+c))" do
      expect(Stat_Calculator.chi_square(1, 1, 2, 2)).to eql 0.0
      expect(Stat_Calculator.chi_square(4, 2, 2, 4)).to eql 1.333
    end

    it "should round to 3 decimal places" do
      expect(Stat_Calculator.chi_square(1,2,3,4).to_s).to match /\d+\.\d{3}/
    end

    it "should raise an error if any of a,b,c,d are < 0" do
      expect{Stat_Calculator.chi_square(-1, 2, 3, 4)}.to raise_error(ArgumentError, "Numbers should be greater than 0")
      expect{Stat_Calculator.chi_square(1, -2, 3, 4)}.to raise_error(ArgumentError, "Numbers should be greater than 0")
      expect{Stat_Calculator.chi_square(1, 2, -3, 4)}.to raise_error(ArgumentError, "Numbers should be greater than 0")
      expect{Stat_Calculator.chi_square(1, 2, 3, -4)}.to raise_error(ArgumentError, "Numbers should be greater than 0")
    end

    it "should raise an error if more or less than 4 values are passed in" do
      expect{Stat_Calculator.chi_square(2, 3, 4)}.to raise_error(NotImplementedError, "Not implemented chi_square calculation for non-2x2 experiment")
      expect{Stat_Calculator.chi_square(1, 2, 3, 4, 5)}.to raise_error(NotImplementedError, "Not implemented chi_square calculation for non-2x2 experiment")
    end

    it "should raise an error if non-numeric values are passed in" do
      expect{Stat_Calculator.chi_square("text", 2, 4, :symbol)}.to raise_error(ArgumentError, "Expect numbers to calculate")
    end
  end

  describe "#conversion" do
    it "should return conversion for successes/total" do
      expect(Stat_Calculator.conversion(1, 2)).to eql 0.5
    end

    it "should raise an error if converted < 0 or hits < 0" do
      expect{Stat_Calculator.conversion(-1, 2)}.to raise_error(ArgumentError, "Require hits >= converted > 0")
      expect{Stat_Calculator.conversion(1, -2)}.to raise_error(ArgumentError, "Require hits >= converted > 0")
    end

    it "should raise an error if converted > hits" do
      expect{Stat_Calculator.conversion(2, 1)}.to raise_error(ArgumentError, "Require hits >= converted > 0")
    end

    it "should round to 2 decimal places" do
      expect(Stat_Calculator.conversion(1, 3).to_s).to match /\d+\.\d{2}/
    end
  end

end
