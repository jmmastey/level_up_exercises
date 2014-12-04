require 'rails_helper'

RSpec.describe Watch, type: :model do
  let(:region) { FactoryGirl.create(:region) }
  let(:station) { FactoryGirl.create(:station) }

  context "when initialized with an item and order" do
    subject(:valid_watch) { FactoryGirl.build(:watch) }

    it { is_expected.to be_valid }
  end

  context "when initialized without an item" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, item: nil)
    end

    it { is_expected.not_to be_valid }
  end

  context "when initialized without an user" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, user: nil)
    end

    it { is_expected.not_to be_valid }
  end

  context "when initialized with a region" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, region: region)
    end

    it { is_expected.to be_valid }
  end

  context "when initialized with a station" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, station: station)
    end

    it { is_expected.to be_valid }
  end

  context "when initialized with both a region and station" do
    subject(:invalid_watch) do
      FactoryGirl.build(:watch, region: region, station: station)
    end

    it { is_expected.not_to be_valid }
  end
end
