require 'rspec'
require './arrowhead.rb'

describe Arrowhead do
  it 'is Oxbow' do
    classify = Arrowhead.classify(:northern_plains, :bifurcated)
    output = "You have a(n) 'Oxbow' arrowhead.  Probably priceless."
    expect(classify).to eq(output)
  end

  it 'test region' do
    output = "Unknown region."
    expect { Arrowhead.classify(:midwest, :bifurcated) }.to raise_error(output)
  end

  it 'test shape' do
    output = "Unknown shape value."
    expect { Arrowhead.classify(:northern_plains, :tri) }.to raise_error(output)
  end
end
