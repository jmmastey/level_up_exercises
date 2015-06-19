require_relative "spec_helper"

describe Bomb do
  let(:activation_code) { "1234" }
  let(:deactivation_code) { "0000" }
  let(:bad_code) { "bad_code" }
  subject(:bomb) { described_class.new(activation_code, deactivation_code) }

  describe "#new" do
    it "requires activation and deactivation codes" do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it "creates an inactive bomb" do
      expect(bomb).to be_inactive
    end
  end

  describe "#enter_code" do
    let(:enter_activation_code) { bomb.enter_code(activation_code) }
    let(:enter_deactivation_code) { bomb.enter_code(deactivation_code) }
    let(:enter_bad_code) { bomb.enter_code(bad_code) }

    shared_examples "code entering" do
      it "returns the bomb" do
        expect(bomb.enter_code(bad_code)).to be_a(described_class)
      end
    end

    context "when inactive" do
      include_examples "code entering"

      context "when entering a bad code" do

      end
    end

    context "when active" do
      before(:each) { bomb.enter_code(activation_code) }

      include_examples "code entering"
    end
  end
end
