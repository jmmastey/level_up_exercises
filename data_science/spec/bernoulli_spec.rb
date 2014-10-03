require 'spec_helper'
require_relative '../bernoulli'

describe Bernoulli do
  let(:empty_bernoulli) { Bernoulli.new }
  let(:first_bernoulli) { create_bernoulli(3, 1) }

  let(:accum_bernoulli) do
    bernoulli = Bernoulli.new
    bernoulli.accumulate(first_bernoulli)
    bernoulli
  end

  it 'should be empty when first created' do
    expect(empty_bernoulli.n).to eq(0)
    expect(empty_bernoulli.p).to be_within(an_angstrom).of(0.0)
    expect(empty_bernoulli.q).to be_within(an_angstrom).of(0.0)
    expect(empty_bernoulli.se).to be_within(an_angstrom).of(0.0)
  end

  it 'should show correct values for 3 out of 4' do
    expect(first_bernoulli.n).to eq(4)
    expect(first_bernoulli.p).to be_within(an_angstrom).of(0.75)
    expect(first_bernoulli.q).to be_within(an_angstrom).of(0.25)
    expect(first_bernoulli.se).to be_within(an_angstrom).of(0.216506351)
  end

  it 'should show correct values after accumulating another bernoulli' do
    expect(accum_bernoulli.n).to eq(4)
    expect(accum_bernoulli.p).to be_within(an_angstrom).of(0.75)
    expect(accum_bernoulli.q).to be_within(an_angstrom).of(0.25)
    expect(accum_bernoulli.se).to be_within(an_angstrom).of(0.216506351)
  end

  it 'should show the correct chi_component' do
    expect(first_bernoulli.chi_component(0.5)).to be_within(an_angstrom).of(1.0)
  end

end
