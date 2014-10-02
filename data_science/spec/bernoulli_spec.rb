require 'spec_helper'
require_relative '../bernoulli'

describe Bernoulli do
  let(:bernoulli) { Bernoulli.new }
  let(:other_bernoulli) { Bernoulli.new }
  let(:an_angstrom) { 1e-10 }

  it 'should be empty when first created' do
    expect(bernoulli.n).to eq(0)
    expect(bernoulli.p).to be_within(an_angstrom).of(0.0)
    expect(bernoulli.q).to be_within(an_angstrom).of(0.0)
    expect(bernoulli.se).to be_within(an_angstrom).of(0.0)
  end

  it 'should show correct values for 3 out of 4' do
    3.times { bernoulli.update(true) }
    1.times { bernoulli.update(false) }
    expect(bernoulli.n).to eq(4)
    expect(bernoulli.p).to be_within(an_angstrom).of(0.75)
    expect(bernoulli.q).to be_within(an_angstrom).of(0.25)
    expect(bernoulli.se).to be_within(an_angstrom).of(0.216506351)
  end

  it 'should show correct values after accumulating another bernoulli' do
    3.times { other_bernoulli.update(true) }
    1.times { other_bernoulli.update(false) }
    bernoulli.accumulate(other_bernoulli)
    expect(bernoulli.n).to eq(4)
    expect(bernoulli.p).to be_within(an_angstrom).of(0.75)
    expect(bernoulli.q).to be_within(an_angstrom).of(0.25)
    expect(bernoulli.se).to be_within(an_angstrom).of(0.216506351)
  end

end
