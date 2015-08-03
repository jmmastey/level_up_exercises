require_relative "spec_helper"

describe WireBundle do
  let(:disarming_wire_count) { 3 }
  let(:detonating_wire_count) { 2 }
  let(:total_wire_count) { disarming_wire_count + detonating_wire_count }
  subject(:bundle) do
    described_class.new(disarming_wire_count, detonating_wire_count)
  end

  describe "#new" do
    it "requires a number of disarm and detonating wires" do
      expect(bundle.disarming_wires.length).to eq(disarming_wire_count)
      expect(bundle.detonating_wires.length).to eq(detonating_wire_count)
      expect(bundle.wires.length).to eq(total_wire_count)
    end
  end

  describe "#disarming_wires" do
    subject(:disarming_wires) { bundle.disarming_wires }

    it { is_expected.to all(be_disarming) }
  end

  describe "#detonating_wires" do
    subject(:detonating_wires) { bundle.detonating_wires }

    it { is_expected.to all(be_detonating) }
  end

  context "when no exploding wires exist" do
    let(:detonating_wire_count) { 0 }

    it { is_expected.not_to be_detonating }
  end

  context "when all exploding wires are intact" do
    shared_examples "not exploding" do
      it { is_expected.not_to be_detonating }
    end

    context "and all disarming wires are intact" do
      include_examples "not exploding"

      it { is_expected.not_to be_disarming }
    end

    context "and some disarming wires are intact" do
      before(:each) { bundle.disarming_wires.first.cut }

      include_examples "not exploding"

      it { is_expected.not_to be_disarming }
    end

    context "and no disarming wires are intact" do
      before(:each) { bundle.disarming_wires.each(&:cut) }

      include_examples "not exploding"

      it { is_expected.to be_disarming }
    end
  end

  context "when any detonating wires have been cut" do
    before(:each) { bundle.detonating_wires.first.cut }

    it { is_expected.to be_detonating }
  end
end
