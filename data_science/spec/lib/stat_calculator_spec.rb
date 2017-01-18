# require './calc_split_test'
require 'rubygems'
require_relative '../../lib/stat_calculator.rb'
require_relative './matchers.rb'
require 'rspec/expectations'
require 'pry'
require_relative './stat_calculator_spec_helper.rb'

describe StatCalculator, 'conversion_rate' do


  RSpec.configuration do |config|
    config.include Matchers
  end

  RSpec::Matchers.define :an_exception_caused_by do |cause|
    match do |exception|
      cause === exception.cause
    end
  end

  let(:stat_calc) { StatCalculator.new }

  it "should calculate conversion rate accurately" do
    expect([12,45]).to have_conversion_rate(0.27)
  end

  it "should raise error when number of trails is 0 or negative" do
     ex = ERRORS[:conversion][:trials_zero_or_negative]
     expect{ stat_calc.conversion_rate(36, 0) }.to raise_error(*ex)
     expect{ stat_calc.conversion_rate(14, -2) }.to raise_error(*ex)
  end

  it "should raise error when conversion is greater than 1" do
   ex = ERRORS[:conversion][:success_greater_trial]
   expect{ stat_calc.conversion_rate(4,1) }.to raise_error(*ex)
  end

  it "should raise error when number of success is 0 or negative" do
    ex = ERRORS[:conversion][:success_zero_or_negative]
    expect{ stat_calc.conversion_rate(0,78) }.to raise_error(*ex)
    expect{ stat_calc.conversion_rate(-3, 45) }.to raise_error(*ex)
  end
end

describe StatCalculator, 'standard_error' do

  let(:stat_calc) { StatCalculator.new }

  it "should calculate standard error accurately" do
    expect([0.27,45]).to have_standard_error(0.066)
  end

  it "should raise error when conversion rate is 0 or negative" do
    ex = ERRORS[:standard_error][:conv_zero_or_negative]
    expect{ stat_calc.standard_error(0,39) }.to raise_error(*ex)
    expect{ stat_calc.standard_error(-2, 40) }.to raise_error(*ex)
  end

  it "should raise error when number of trials is 0 or negative" do
    ex = ERRORS[:conversion][:trials_zero_or_negative]
    expect{ stat_calc.standard_error(4,0) }.to raise_error(*ex)
    expect{ stat_calc.standard_error(9,-2) }.to raise_error(*ex)
  end

  it "should raise error when conversion rate greater than or equal to 1" do
    ex = ERRORS[:standard_error][:conv_greater_one]
    expect{ stat_calc.standard_error(1.2, 46) }.to raise_error(*ex)
  end
end

describe StatCalculator, 'confidence' do

  let(:stat_calc) { StatCalculator.new }

   it "should calculate confidence accuartely" do
    expect([0.066,0.27]).to have_confidence([7.14, 6.06])
  end

  it "should raise error when conversion rate is zero or negative" do
    ex = ERRORS[:standard_error][:conv_zero_or_negative]
    expect{ stat_calc.confidence(0, 0.04) }.to raise_error(*ex)
    expect{ stat_calc.confidence(-0.45, 0.05) }.to raise_error(*ex)
  end

  it "should raise error when standard_error is zero or negative" do
    ex = ERRORS[:confidence][:standard_error_zero_negative]
    expect{ stat_calc.confidence(0.45, 0) }.to raise_error(*ex)
    expect{ stat_calc.confidence(0.56, -1) }.to raise_error(*ex)
  end
end
