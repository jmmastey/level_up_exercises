require "rails_helper"

describe Merchant do
  let(:merchant) { FactoryGirl.build(:merchant) }

  describe "#name" do
    it "is required" do
      merchant.name = ""
      expect(merchant).not_to be_valid
    end
  end

  describe "#location" do
    it "is required" do
      merchant.location = nil
      expect(merchant).not_to be_valid
    end
  end
end
