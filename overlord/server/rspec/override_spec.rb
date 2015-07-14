require_relative '../bomb'

describe Bomb do
  context "override spec" do
    let(:bomb) { Bomb.new }

    it "overrides basic inspection" do
      expect(bomb.inspect).to eq("It's a bomb")
    end

    it "overrides basic to_s" do
      expect(bomb.to_s).to eq("Bomb")
    end
  end
end
