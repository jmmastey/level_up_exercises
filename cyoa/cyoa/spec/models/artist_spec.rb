require 'spec_helper'

describe Artist do
  subject(:artist) { FactoryGirl.create(:artist) }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:metrics) }
  it { is_expected.to respond_to(:songs) }
  it { is_expected.to respond_to(:users) }

  describe "#name" do
    it { is_expected.to respond_to(:name) }

    it "must have a name" do
      expect(FactoryGirl.build(:artist, name: "")).not_to be_valid
    end

    it "name of artist is unique" do
      expect(FactoryGirl.build(:another_artist, name: artist.name.downcase)).not_to be_valid
    end

    it "can be searched case-insensitively" do
      expect(Artist.find_by_unique_name(artist.name)).not_to be_nil
      expect(Artist.find_by_unique_name(artist.name.upcase)).not_to be_nil
      expect(Artist.find_by_unique_name(artist.name.downcase)).not_to be_nil
      expect(Artist.find_by_unique_name("Something That Doesn't Exist")).to be_nil
    end

    it "can locate or create a unique entry" do
      expect(Artist.find_or_create_by_unique_name("Something Whatever")).not_to be_nil
      expect(Artist.find_or_create_by_unique_name(artist.name.upcase)).to eq(artist)
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
