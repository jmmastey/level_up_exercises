require 'json'
require 'abanalyzer'
include Math

class ABCalculator
  def initialize(a_b_data)
    @a_data = a_b_data[:a_group]
    @b_data = a_b_data[:b_group]
    @a_b_tester = ABAnalyzer::ABTest.new(a_b_data)
  end

  def sample_size
    {
      a: @a_data[:pass] + @a_data[:fail],
      b: @b_data[:pass] + @b_data[:fail],
    }
  end

  def conversion_rate
    {
      a: @a_data[:pass].to_f / sample_size[:a],
      b: @b_data[:pass].to_f / sample_size[:b],
    }
  end

  def conversion_range
    {
      a: 
      { 
        lo: conversion_rate[:a] - 1.96 * standard_error[:a],
        hi: conversion_rate[:a] + 1.96 * standard_error[:a],
      },
      b: 
      {
        lo: conversion_rate[:b] - 1.96 * standard_error[:b],
        hi: conversion_rate[:b] + 1.96 * standard_error[:b],
      } 
    }
  end

  def confidence_level
    1 - chi_square_p_value
  end

  private

  def standard_error
    {
      a: sqrt(conversion_rate[:a] * (1-conversion_rate[:a]) / sample_size[:a]),
      b: sqrt(conversion_rate[:b] * (1-conversion_rate[:b]) / sample_size[:b]),
    }
  end

  def chi_square_p_value
    @a_b_tester.chisquare_p
  end
end
