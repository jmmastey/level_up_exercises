require "spec_helper"

describe Category do
  subject(:category) { FactoryGirl.create(:category) }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:name) }

  describe "#name" do
    it "must have a name" do
      expect(FactoryGirl.build(:category, name: nil)).not_to be_valid
    end

    it "must have a unique name" do
      expect(FactoryGirl.build(:category, name: category.name.upcase)).not_to be_valid
    end
  end
end
