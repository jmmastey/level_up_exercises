require 'spec_helper'
require_relative '../safe_math'

describe SafeMath do
  let(:an_angstrom) { 1e-10 }

  it 'should divide by non-zero like normal division' do
    expect(SafeMath.divide(5, 8)).to be_within(an_angstrom).of(0.625)
  end

  it 'should divide by zero by answering zero' do
    expect(SafeMath.divide(5, 0)).to be_within(an_angstrom).of(0.0)
    expect(SafeMath.divide(0, 0)).to be_within(an_angstrom).of(0.0)
  end
end
