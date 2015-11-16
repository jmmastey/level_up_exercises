require "rails_helper"

describe Menu, type: :model do
  let(:menu) { FactoryGirl.build(:menu) }

  describe "#name" do
    it "is required" do
      menu.name = ""
      expect(menu).not_to be_valid
    end
  end

  describe "#merchant" do
    it "is required" do
      menu.merchant = nil
      expect(menu).not_to be_valid
    end
  end
end
