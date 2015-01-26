require "overlord/bomb"

module Overlord
  describe Bomb do
    describe "#status" do
      it "returns 'Setup' when first created" do
        bomb = Bomb.new
        expect(bomb.status).to eq("Setup")
      end
      it "returns 'Ready' after codes have been set" do
        bomb = Bomb.new
        bomb.setup("1234", "0000") 
        expect(bomb.status).to eq("Ready")
      end
      it "returns 'Activated' after activation code has been entered" do
        bomb = Bomb.new
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        expect(bomb.status).to eq("Activated")
      end
      it "returns 'Activated' after default activation code has been entered" do
        bomb = Bomb.new
        bomb.setup("", "")
        bomb.activate("1234")
        expect(bomb.status).to eq("Activated")
      end
      it "returns 'Ready' after deactivation" do
        bomb = Bomb.new
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        bomb.deactivate("0000")
        expect(bomb.status).to eq("Ready")
      end
      it "returns 'Ready' after deactivation with default code" do
        bomb = Bomb.new
        bomb.setup("", "")
        bomb.activate("1234")
        bomb.deactivate("0000")
        expect(bomb.status).to eq("Ready")
      end
      it "returns 'BOOM' after unsuccessful deactivation" do
        bomb = Bomb.new
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        3.times { bomb.deactivate("9999") }
        expect(bomb.status).to eq("BOOM")
      end
    end
    describe "#errors" do
      it "returns 'Invalid Activation Code' after invalid activation code has been entered" do
        bomb = Bomb.new
        bomb.setup("1234", "0000")
        bomb.activate("4321")
        expect(bomb.errors).to eq(["Invalid Activation Code"])
      end
      it "returns 'Invalid Deactivation Code' after invalid deactivation code has been entered" do
        bomb = Bomb.new
        bomb.setup("1234", "0000")
        bomb.activate("1234")
        bomb.deactivate("9999")
        expect(bomb.errors).to eq(["Invalid Deactivation Code"])
      end
      it "returns 'Invalid Activation Code' after invalid activation code has been entered during setup" do
        bomb = Bomb.new
        bomb.setup("abcd", "0000")
        expect(bomb.errors).to eq(["Invalid Activation Code"])
      end
      it "returns 'Invalid Deactivation Code' after invalid deactivation code has been entered during setup" do
        bomb = Bomb.new
        bomb.setup("1234", "abcd")
        expect(bomb.errors).to eq(["Invalid Deactivation Code"])
      end
    end
  end
end
