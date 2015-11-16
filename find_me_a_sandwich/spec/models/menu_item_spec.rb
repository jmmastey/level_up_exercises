require "rails_helper"

describe MenuItem, type: :model do
  let(:item) { FactoryGirl.build(:menu_item) }

  describe "#name" do
    it "is required" do
      item.name = ""
      expect(item).not_to be_valid
    end
  end

  describe "#menu" do
    it "is required" do
      item.menu = nil
      expect(item).not_to be_valid
    end
  end
end
