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

  describe "#phone" do
    it "is required" do
      merchant.phone = ""
      expect(merchant).not_to be_valid
    end
  end

  describe "#description" do
    it "is required" do
      merchant.description = ""
      expect(merchant).not_to be_valid
    end
  end
end
