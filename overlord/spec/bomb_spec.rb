require 'spec_helper'

describe Bomb do
  describe "#new" do
    it "accepts only 4-digit numbers for the activation code"
    it "accepts only 4-digit numbers for the deactivation code"
    it "defaults to 1234 as the activation code if no code is entered"
    it "defaults to 0000 as the deactivation code is no code is entered"
    it "is initialized with 3 deactivation attempts remaining"
  end
end
