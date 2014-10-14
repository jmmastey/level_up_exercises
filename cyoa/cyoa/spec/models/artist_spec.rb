require 'spec_helper'

describe Artist do
  subject(:artist) { FactoryGirl.create(:artist) }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:metrics) }
  it { is_expected.to respond_to(:songs) }

  describe "required attributes" do
    it "must have a name" do
      expect(FactoryGirl.build(:artist, name: "")).not_to be_valid
    end
  end

  describe "adding a new artist with duplicate attributes" do
    it "name of artist is unique" do
      expect(FactoryGirl.build(:artist, name: artist.name.downcase, grooveshark_id: 1, nbs_id: 1)).not_to be_valid
    end

    it "api ids are unique" do
      expect(FactoryGirl.build(:another_artist, grooveshark_id: artist.grooveshark_id)).not_to be_valid
      expect(FactoryGirl.build(:another_artist, nbs_id: artist.nbs_id)).not_to be_valid
    end
  end
end
