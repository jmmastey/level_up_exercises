require 'spec_helper'
require_relative '../chi_square'
require_relative 'math_helper'

describe ChiSquare do
  let(:empty_chi_square) { ChiSquare.new }

  let(:chi_square) do
    chi_square = ChiSquare.new

    bernoulli = create_bernoulli(4, 4)
    chi_square.add(bernoulli)

    bernoulli = create_bernoulli(9, 7)
    chi_square.add(bernoulli)
    
    chi_square
  end

  it 'should return zero chi-value when empty' do
    expect(empty_chi_square.value).to be_within(an_angstrom).of(0.0)
  end

  it 'should return correct chi-value' do
    expect(chi_square.value).to be_within(an_angstrom).of(0.0839160839)
  end

  it 'should return correct significance-value' do
    expect(chi_square.significance).to be_within(an_angstrom).of(0.2279410302)
  end

  it 'should not have rejected the null hypothesis' do
    expect(chi_square).not_to have_rejected_null_hypothesis
  end
end
