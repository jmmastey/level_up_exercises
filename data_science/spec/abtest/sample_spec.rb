require "abtest/sample"

module ABTest
  describe Sample do
    describe "#==" do
      it "returns true when the fields of two sample objects are the same" do
        expect(Sample.new("2015-01-05", "X", 1)).to \
          eq(Sample.new("2015-01-05", "X", 1))
      end
      it "returns false when the fields of two sample objects are different" do
        expect(Sample.new("2015-01-05", "Y", 1)).not_to \
          eq(Sample.new("2015-01-05", "X", 1))
      end
    end
  end
end
