require 'spec_helper'

describe Artist do
  subject(:artist) { FactoryGirl.create(:artist) }

  it { is_expected.to be_valid }

  it { should have_many(:metrics) }
  it { should have_and_belong_to_many(:users) }

  describe "#name" do
    it { is_expected.to respond_to(:name) }

    it "must have a name" do
      expect(FactoryGirl.build(:artist, name: "")).not_to be_valid
    end

    it "name of artist is unique" do
      artist_with_same_name = FactoryGirl.build(:another_artist, name: artist.name.downcase)
      expect(artist_with_same_name).not_to be_valid
    end

    it "can be searched case-insensitively" do
      expect(Artist.find_by_unique_name(artist.name)).not_to be_nil
      expect(Artist.find_by_unique_name(artist.name.upcase)).not_to be_nil
      expect(Artist.find_by_unique_name(artist.name.downcase)).not_to be_nil
      expect(Artist.find_by_unique_name("Something That Doesn't Exist")).to be_nil
    end

    it "can locate or create a unique entry" do
      new_artist_to_search_for = "Something Whatever"
      new_artist_search_result = Artist.find_or_create_by_unique_name(new_artist_to_search_for)
      expect(new_artist_search_result).not_to be_nil

      artist_search_result_uppercase = Artist.find_or_create_by_unique_name(artist.name.upcase)
      expect(artist_search_result_uppercase).to eq(artist)
    end
  end

  context "Next Big Sound API" do
    describe "#nbs_id" do
      it "has a unique nbs id" do
        artist_with_duplicate_nbs_id = FactoryGirl.build(:another_artist, nbs_id: artist.nbs_id)
        expect(artist_with_duplicate_nbs_id).not_to be_valid
      end
    end

    describe "#nbs_name" do
      it "stores the next big sound name" do
        kanye = Artist.create(name: "kanye west")
        expect(kanye.nbs_name).to eq("Kanye West")
      end
    end
  end

  describe "#grooveshark_id" do
    it "has a unique grooveshark id" do
      artist_with_duplicate_api_id = FactoryGirl.build(:another_artist, grooveshark_id: artist.grooveshark_id)
      expect(artist_with_duplicate_api_id).not_to be_valid
    end
  end
end
