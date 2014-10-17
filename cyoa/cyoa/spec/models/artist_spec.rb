require 'spec_helper'

describe Artist do
  subject(:artist) { FactoryGirl.create(:artist) }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:metrics) }
  it { is_expected.to respond_to(:songs) }

  describe "#name" do
    it { is_expected.to respond_to(:name) }

    it "must have a name" do
      expect(FactoryGirl.build(:artist, name: "")).not_to be_valid
    end

    it "name of artist is unique" do
      expect(FactoryGirl.build(:another_artist, name: artist.name.downcase)).not_to be_valid
    end
  end

  describe "#nbs_id" do
    it "has a unique nbs id" do
      expect(FactoryGirl.build(:another_artist, nbs_id: artist.nbs_id)).not_to be_valid
    end
  end

  describe "#grooveshark_id" do
    it "has a unique grooveshark id" do
      expect(FactoryGirl.build(:another_artist, grooveshark_id: artist.grooveshark_id)).not_to be_valid
    end
  end
end
