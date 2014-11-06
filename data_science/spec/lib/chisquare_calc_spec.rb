require_relative '../../lib/chisquare_calc'
require './stat_calculator_spec_helper.rb'
require_relative './matchers.rb'

describe ChiSquareCalc, 'positive tests' do

  RSpec.configuration do |config|
    config.include Matchers
  end

  it "should calculate chi square accurately" do
    expect([2,5,3,8]).to have_chi_square(0.01)
  end

  it "should receive even number of arguments for calculation" do
    ex = ERRORS[:chisquare][:wrong_args]
    expect{ ChiSquareCalc.calc_chisquare(1,2,3) }.to raise_error(*ex)
  end

  it "should throw error if any of the arguments is negative" do
    ex = ERRORS[:chisquare][:negative_arg]
    expect{ ChiSquareCalc.calc_chisquare(1,-2,-3,4) }.to raise_error(*ex)
  end

  it "should throw error if any of the argument is not a numeric argument" do
    ex = ERRORS[:chisquare][:numeric_arg]
    expect{ ChiSquareCalc.calc_chisquare('r',1,2,9) }.to raise_error(*ex)
  end
end
