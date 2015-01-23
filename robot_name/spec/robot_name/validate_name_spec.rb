require './spec/spec_helper.rb'

describe ValidateName do
  describe "#self.name_exists?" do
    let(:registry) { %w(inga KAI svajone) }
    context "when name exists" do
      it "returns true" do
        expect(ValidateName.name_exists?(registry, 'inga')).to be_truthy
      end
    end
    context "when name does not exists" do
      it "returns false" do
        expect(ValidateName.name_exists?(registry, 'vaida')).to be_falsey
      end
    end
  end
  describe "#self.match_regex?" do
    context "when it matches the regex" do
      let(:name) { 'SV407' }
      it "returns true" do
        expect(ValidateName.match_regex?(name)).to be_truthy
      end
    end
    context "when it does not match the regex" do
      let(:name) { '1V407' }
      it "returns false" do
        expect(ValidateName.match_regex?(name)).to be_falsey
      end
    end
  end
end
