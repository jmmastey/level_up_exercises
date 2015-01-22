require './spec/spec_helper.rb'

describe NameGenerator do
  describe "#call" do
    context "when length is set" do
      let(:name_generator) { NameGenerator.call(length: 10) }
      it "generates a name" do
        expect(name_generator).to be_truthy
      end
      it "has a length equal to what is set" do
        expect(name_generator.length).to eq(10)
      end
    end
    context "when length is not set" do
      let(:name_generator) { NameGenerator.call }
      it "generates a name" do
        expect(name_generator).to be_truthy
      end
      it "has a length equal to default" do
        expect(name_generator.length).to eq(5)
      end
    end
  end
end
