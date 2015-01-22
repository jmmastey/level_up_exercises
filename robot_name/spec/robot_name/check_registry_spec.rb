require './spec/spec_helper.rb'

describe CheckRegistry do
  describe "#name_exists?" do
    let(:registry) { ['inga', 'KAI', 'svajone'] }
    context "when name exists" do
      it "returns true" do
        expect(CheckRegistry.name_exists?(registry, 'inga')).to be_truthy
      end
    end
    context "when name does not exists" do
      it "returns false" do
        expect(CheckRegistry.name_exists?(registry, 'vaida')).to be_falsey
      end
    end
  end
end
