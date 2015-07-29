require 'spec_helper'
require 'bomb'

describe Bomb do
  let(:ACTIVATION) { "6667" }
  let(:DEACTIVATION) { "8889" }
  let(:OTHER) { "0987" }

  context "a newly created bomb" do
    let(:new_bomb) { Bomb.new(ACTIVATION, DEACTIVATION) }

    it "is not .active?" do
      expect(new_bomb).not_to be_active
    end

    it "is not .disabled?" do
      expect(new_bomb).not_to be_disabled
    end

  context "an inactive bomb" do
    let(:inactive_bomb) { Bomb.new(ACTIVATION, DEACTIVATION) }

    it "cannot explode" do
      inactive_bomb.explode!
      expect(inactive_bomb).not_to be_exploded
    end

    it "is not activated by an attempt to explode it" do
      inactive_bomb.explode!
      expect(inactive_bomb).not_to be_active
    end

    it "is not activated by entering an incorrect activation code" do
      inactive_bomb.enter_code(OTHER)
      expect(inactive_bomb).not_to be_active
    end

    it "is activated by entering the correct activation code" do
      inactive_bomb.enter_code(ACTIVATION)
      expect(inactive_bomb).to be_active
    end

    it "can be disabled with .cut_wires!" do
      inactive_bomb.cut_wires!
      expect(inactive_bomb).to be_disabled
    end
  end

  context "an active bomb" do
    let(:active_bomb) do
      Bomb.new(ACTIVATION, DEACTIVATION)
      active_bomb.enter_code(ACTIVATION)
    end

    it "can explode" do
      active_bomb.explode!
      expect(active_bomb).to be_exploded
    end

    it "is deactivated by entering the correct deactivation code" do
      active_bomb.enter_code(DEACTIVATION)
      expect(active_bomb).no_to be_active
    end

    it "is not deactivated by entering an incorrect deactivation code" do
      active_bomb.enter_code(OTHER)
      expect(active_bomb).to be_active
    end

    it "will not explode on first two incorrect deactivation code entries" do
      2.times active_bomb.enter_code(OTHER)
      expect(active_bomb).not_to be_exploded
    end

    it "will explode on third incorrect deactivation code entry" do
      3.times active_bomb.enter_code(OTHER)
    end

    it "will not explode from re-entry of activation code" do
      3.times active_bomb.enter_code(ACTIVATION)
      expect(active_bomb).not_to be_exploded
    end

    it "can be disabled with .cut_wires!" do
      active_bomb.cut_wires!
      expect(active_bomb).to be_disabled
    end
  end

  context "a disabled bomb" do
    let(:disabled_bomb) do
      Bomb.new(ACTIVATION, DEACTIVATION)
      disabled_bomb.enter_code(ACTIVATION)
      disabled_bomb.cut_wires
    end
    
    it "cannot explode" do
      disabled_bomb.explode!
      expect(disabled_bomb).not_to be_exploded
    end
  end
end
