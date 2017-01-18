require_relative '../../lib/stat_calculator.rb'
require_relative '../../lib/chisquare_calc.rb'
require 'pry'

module Matchers

  RSpec::Matchers.define :have_conversion_rate do |expected|
    match do |actual|
      binding.pry
      StatCalculator.new.conversion_rate(*actual) == expected
    end
  end

  RSpec::Matchers.define :have_standard_error do |expected|
    match do |actual|
      StatCalculator.new.standard_error(*actual) == expected
    end
  end

  RSpec::Matchers.define :have_confidence do |expected|
    match do |actual|
      StatCalculator.new.confidence(*actual) == expected
    end
  end

  RSpec::Matchers.define :have_chi_square do |expected|
    match do |actual|
      ChiSquareCalc.calc_chisquare(*actual) == expected
    end
  end
end
