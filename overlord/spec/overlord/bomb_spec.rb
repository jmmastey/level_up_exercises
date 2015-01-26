require "overlord/bomb"

module Overlord
  describe Bomb do
    let(:bomb) { Bomb.new }

    describe "#new" do
      it "status is 'Setup' when bomb is first created" do
        expect(bomb.status).to eq("Setup")
      end
    end

    describe "#setup" do
      it "sets status to 'Ready' when called with valid codes" do
        bomb.setup("1234", "0000")
        expect(bomb.status).to eq("Ready")
      end
      it "sets status to 'Ready' when called with blank codes" do
        bomb.setup("", "")
        expect(bomb.status).to eq("Ready")
      end
      it "sets errors to 'Invalid Activation Code' when called with invalid activation code" do
        bomb.setup("abcd", "0000")
        expect(bomb.errors).to eq(["Invalid Activation Code"])
      end
      it "sets errors to 'Invalid Deactivation Code' when called with invalid deactivation code" do
        bomb.setup("1234", "abcd")
        expect(bomb.errors).to eq(["Invalid Deactivation Code"])
      end
    end

    describe "#activate" do
      it "sets status to 'Activated' when called with correct activation code" do
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        expect(bomb.status).to eq("Activated")
      end
      it "sets status to 'Activated' when called with default activation code" do
        bomb.setup("", "")
        bomb.activate("1234")
        expect(bomb.status).to eq("Activated")
      end
      it "sets errors to 'Invalid Activation Code' when called with incorrect activation code" do
        bomb.setup("1234", "0000")
        bomb.activate("4321")
        expect(bomb.errors).to eq(["Invalid Activation Code"])
      end
      it "does not change status when called with incorrect activation code" do
        bomb.setup("1234", "0000")
        bomb.activate("4321")
        expect(bomb.status).to eq("Ready")
      end
    end

    describe "#deactivate" do
      it "sets status to 'Ready' when called with correct deactivation code" do
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        bomb.deactivate("0000")
        expect(bomb.status).to eq("Ready")
      end
      it "sets status to 'Ready' when called with default deactivation code" do
        bomb.setup("", "")
        bomb.activate("1234")
        bomb.deactivate("0000")
        expect(bomb.status).to eq("Ready")
      end
      it "sets errors to 'Invalid Deactivation Code' when called with incorrect deactivation code" do
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        bomb.deactivate("9999")
        expect(bomb.errors).to eq(["Invalid Deactivation Code"])
      end
      it "does not change status when called with incorrect deactivation code once" do
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        bomb.deactivate("9999")
        expect(bomb.status).to eq("Activated")
      end
      it "sets status to 'BOOM' when called with incorrect deactivation code too many times" do
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        3.times { bomb.deactivate("9999") }
        expect(bomb.status).to eq("BOOM")
      end
    end
  end
end
