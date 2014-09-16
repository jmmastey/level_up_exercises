require "rspec"

require_relative "../src/bomb"

describe Bomb do
  context "upon creation" do
    let(:bomb) { Bomb.new }

    it "should not be activate and not blown up" do
      expect(bomb).not_to be_active
      expect(bomb).not_to be_blown_up
    end

    it "should be able to be activated with code" do
      bomb.activate("1234")
      expect(bomb).to be_active
    end

    it "should throw error with bad code" do
      expect { bomb.activate(01) }.to raise_error
      expect { bomb.activate("12345") }.to raise_error
      expect { bomb.activate("not int") }.to raise_error
    end
  end

  context "upon default activation" do
    let(:bomb) do
      bomb = Bomb.new
      bomb.activate
      bomb
    end

    it "should be active and not blown up" do
      expect(bomb).to be_active
      expect(bomb).not_to be_blown_up
    end

    it "should be deactivated with 1234" do
      bomb.deactivate("1234")
      expect(bomb).not_to be_active
      expect(bomb).not_to be_blown_up
    end
  end

  context "upon activation" do
    let(:bomb) do
      bomb = Bomb.new
      bomb.activate("4321")
      bomb
    end

    it "should raise error to activate again" do
      expect { bomb.activate("4321") }.to raise_error
    end

    it "should be activate and not blown up" do
      expect(bomb).to be_active
      expect(bomb).not_to be_blown_up
    end

    it "should be deactivated with same code" do
      bomb.deactivate("4321")
      expect(bomb).not_to be_active
      expect(bomb).not_to be_blown_up
    end
  end

  context "upon first wrong guess" do
    let(:bomb) do
      bomb = Bomb.new
      bomb.activate("1234")
      bomb.deactivate("0000")
      bomb
    end

    it "should be active and not blown up" do
      expect(bomb).to be_active
      expect(bomb).not_to be_blown_up
    end
  end

  context "upon second wrong guess" do
    let(:bomb) do
      bomb = Bomb.new
      bomb.activate("1234")
      2.times { bomb.deactivate("0000") }
      bomb
    end

    it "should be blown up and not active" do
      expect(bomb).to be_blown_up
      expect(bomb).not_to be_active
    end
  end

  context "upon blowing up" do
    let(:bomb) do
      bomb = Bomb.new
      bomb.activate("1234")
      2.times { bomb.deactivate("0000") }
      bomb
    end

    it "should throw error on activation" do
      expect { bomb.activate("1234") }.to raise_error
    end

    it "should throw error on deactivation" do
      expect { bomb.deactivate("1234") }.to raise_error
    end
  end
end
