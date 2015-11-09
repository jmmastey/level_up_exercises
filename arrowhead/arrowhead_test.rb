require 'rspec'
require './arrowhead.rb'

describe Arrowhead do
  it 'is Oxbow' do
    classify = Arrowhead.classify(:northern_plains, :bifurcated)
    expect(classify).to eq("You have a(n) 'Oxbow' arrowhead.  Probably priceless.")
  end

  it 'test region' do
    expect{ Arrowhead.classify(:midwest, :bifurcated)}.to raise_error("Unknown region.")
  end

  it 'test shape' do
    expect { Arrowhead.classify(:northern_plains, :round)}.to raise_error("Unknown shape value.")
  end
end