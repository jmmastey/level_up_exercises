require "spec_helper"

describe Service do
  subject(:service) { FactoryGirl.create(:service) }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:metrics) }

  describe "#name" do
    it { is_expected.to respond_to(:name) }

    it "must have a name" do
      expect(FactoryGirl.build(:service, name: nil)).not_to be_valid
    end

    it "must have a unique name" do
      expect(FactoryGirl.build(:another_service, name: service.name.upcase)).not_to be_valid
    end
  end

  describe "#url" do
    it { is_expected.to respond_to(:url) }

    xit "must have a url leading with http:// or https://" do
      pending
    end

    it "must have a unique url" do
      expect(FactoryGirl.build(:service, url: service.url.capitalize)).not_to be_valid
    end
  end
end
