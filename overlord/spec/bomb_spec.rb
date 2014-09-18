require_relative "../lib/bomb.rb"

describe Bomb do
  let(:bomb) { Bomb.new }

  it "initializes in the intact state" do
    expect(bomb).to be_intact
  end

  describe "#explode" do
    it "detonates the bomb" do
      bomb.explode
      expect(bomb).to be_exploded
    end

    it "will raise an ExplodedError if the bomb has already exploded" do
      bomb.explode
      expect { bomb.explode }.to raise_error(ExplodedError)
    end
  end
end
