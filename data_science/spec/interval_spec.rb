require 'spec_helper'
require_relative '../interval'

describe Interval do
  let(:bernoulli) do
    bernoulli = Bernoulli.new
    3.times { bernoulli.update(true) }
    1.times { bernoulli.update(false) }
    bernoulli
  end

  let(:interval) { Interval.new(bernoulli) }


  it 'has correct endpts' do
    expect(interval.lower).to be_within(an_angstrom).of(0.75 - 2 * bernoulli.se)
    expect(interval.upper).to be_within(an_angstrom).of(0.75 + 2 * bernoulli.se)
  end

  it 'has correct midpt' do
    expect(interval.midpt).to be_within(an_angstrom).of(0.75)
  end

end
