require 'spec_helper'

describe Bomb do
  describe "#new" do
    it "raises an error if the activation code is not a 4-digit number"
    it "raises an error if the activation code is not a 4-digit number"
    it "defaults to 1234 as the activation code if no code is entered"
    it "defaults to 0000 as the deactivation code is no code is entered"
    it "is initialized with 3 deactivation attempts remaining"
    it "is not activated upon creation"
    it "has not exploded yet"
  end

  describe "#try_to_activate" do
  	it "activates when the correct activation code is entered"
    it "does not activate if the activation code is not correct"
    it "does nothing if the bomb is already active"
    it "does nothing if the bomb has exploded"
  end

  describe "#try_to_deactivate" do
    it "deactivates the bomb when the correct deactivation code is entered"
    it "allows exactly three deactivation attempts"
    it "explodes after three incorrect deactivation attempts"
  end

  decribe "#exploded?" do
    it "shows that the bomb has not exploded upon boot"
    it "shows that the bomb has not exploded after activation"
    it "does not explode after one or two incorrect deactivation attempts"
    it "explodes after three incorrect deactivation attempts"
  end
end
