require_relative "../bomb_code"

describe BombCode do
  context "upon activation" do
    let(:bomb_code) do
      BombCode.new("0369")
    end

    it "should contain the whole sequence" do
      expect(bomb_code.to_s).to eq("0369")
    end

    it "shoud be able to test equality" do
      equal_code = BombCode.new("0369")
      expect(bomb_code).to eq(equal_code)

      not_equal_code = BombCode.new("9630")
      expect(bomb_code).not_to eq(not_equal_code)
    end
  end

  context("upon receiving bad code") do
    it "should through an error" do
      expect(BombCode.new("test")).to raise_error
    end
  end
end
