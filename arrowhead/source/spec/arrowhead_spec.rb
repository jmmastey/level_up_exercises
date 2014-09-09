# rubocop:disable all
require_relative '../lib/arrowhead.rb'
require_relative 'spec_helper.rb'

describe Arrowhead do
  context 'stubs' do
    it 'will classify correctly #1' do
      response = capture_stdout { Arrowhead::classify(:northern_plains, :bifurcated) }
      expected = [ %{You have a(n) 'Oxbow' arrowhead. Probably priceless.} ]
      expect(response.split("\n").collect(&:strip)).to eq(expected)
    end
    it 'will classify correctly #2' do
      response = capture_stdout { Arrowhead::classify(:far_west, :notched) }
      expected = [ %{You have a(n) 'Archaic Side Notch' arrowhead. Probably priceless.} ]
      expect(response.split("\n").collect(&:strip)).to eq(expected)
    end
  end
end
# rubocop:enable all
