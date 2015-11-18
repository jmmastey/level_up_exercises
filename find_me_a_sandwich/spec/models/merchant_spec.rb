require "rails_helper"

describe Merchant do
  subject(:merchant) { FactoryGirl.build(:merchant) }

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

  describe "#recently_updated?" do
    let(:max_cache_time) { AppConfig.locu.caching_time }

    context "when never updated" do
      it { is_expected.not_to be_recently_updated }
    end

    context "when updated earlier than the specified max cache time" do
      before(:each) do
        merchant.updated_at = max_cache_time.days.ago - 5.seconds
      end

      it { is_expected.not_to be_recently_updated }
    end

    context "when updated later than the specified max cache time" do
      before(:each) do
        merchant.updated_at = max_cache_time.days.ago + 5.seconds
      end

      it { is_expected.to be_recently_updated }
    end
  end
end
