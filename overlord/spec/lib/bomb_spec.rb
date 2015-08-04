require 'spec_helper'
require 'bomb'

describe Bomb do
  let(:activation_code) { "6667" }
  let(:deactivation_code) { "8889" }
  let(:other_code) { "0987" }
  let(:bomb) { Bomb.new("6667", "8889") }

  context "which is newly created" do
    it "is not active" do
      expect(bomb).not_to be_active
    end

    it "is not disabled" do
      expect(bomb).not_to be_disabled
    end
  end

  context "which is inactive" do
    it "cannot explode" do
      bomb.explode!
      expect(bomb).not_to be_exploded
    end

    it "is not activated by an attempt to explode it" do
      bomb.explode!
      expect(bomb).not_to be_active
    end

    it "is not activated by entering an incorrect activation code" do
      bomb.enter_code(other_code)
      expect(bomb).not_to be_active
    end

    it "is activated by entering the correct activation code" do
      bomb.enter_code(activation_code)
      expect(bomb).to be_active
    end

    it "can be disabled by cutting the wires" do
      bomb.cut_wires!
      expect(bomb).to be_disabled
    end
  end

  context "which is active" do
    let(:activated_bomb) { bomb.enter_code(activation_code) }

    it "can explode" do
      activated_bomb.explode!
      expect(activated_bomb).to be_exploded
    end

    it "is deactivated by entering the correct deactivation code" do
      activated_bomb.enter_code(deactivation_code)
      expect(activated_bomb).not_to be_active
    end

    it "is not deactivated by entering an incorrect deactivation code" do
      activated_bomb.enter_code(other_code)
      expect(activated_bomb).to be_active
    end

    it "will not explode on first two incorrect deactivation code entries" do
      2.times { activated_bomb.enter_code(other_code) }
      expect(activated_bomb).not_to be_exploded
    end

    it "will explode on third incorrect deactivation code entry" do
      3.times { activated_bomb.enter_code(other_code) }
      expect(activated_bomb).to be_exploded
    end

    it "will not explode from re-entry of activation code" do
      3.times { activated_bomb.enter_code(activation_code) }
      expect(activated_bomb).not_to be_exploded
    end

    it "can be disabled by cutting the wires" do
      activated_bomb.cut_wires!
      expect(activated_bomb).to be_disabled
    end

    context "which is disabled" do
      let(:disabled_bomb) { activated_bomb.cut_wires }

      it "cannot explode" do
        disabled_bomb.explode!
        expect(disabled_bomb).not_to be_exploded
      end
    end
  end
end
