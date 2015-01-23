require './spec/spec_helper.rb'

describe NameGenerator do
  describe "#self.call" do
    it "generates a name" do
      expect(NameGenerator.call).to_not be_empty
    end
  end
end
