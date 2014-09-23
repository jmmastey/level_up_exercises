require 'spec_helper'
require './max'

describe Max do
  let(:max) { Max.new }

  it 'should return the max of a list of integers' do
    expect(max.value).to be_nil

    max << 1
    expect(max.value).to eq(1)

    max << 4
    expect(max.value).to eq(4)

    max << 9
    expect(max.value).to eq(9)

    max << 3
    expect(max.value).to eq(9)
  end

  it 'should return the max of a list of strings' do
    expect(max.value).to be_nil

    max << 'A'
    expect(max.value).to eq('A')

    max << 'B'
    expect(max.value).to eq('B')

    max << 'D'
    expect(max.value).to eq('D')

    max << 'C'
    expect(max.value).to eq('D')
  end
end

describe Min do
  let(:min) { Min.new }

  it 'should return the min of a list of integers' do
    expect(min.value).to be_nil

    min << 9
    expect(min.value).to eq(9)

    min << 4
    expect(min.value).to eq(4)

    min << 1
    expect(min.value).to eq(1)

    min << 3
    expect(min.value).to eq(1)
  end

  it 'should return the min of a list of strings' do
    expect(min.value).to be_nil

    min << 'D'
    expect(min.value).to eq('D')

    min << 'B'
    expect(min.value).to eq('B')

    min << 'A'
    expect(min.value).to eq('A')

    min << 'C'
    expect(min.value).to eq('A')
  end
end
