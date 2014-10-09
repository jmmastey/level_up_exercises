require 'spec_helper'

describe Artist do
  subject(:artist) do
    Artist.new(name: "Beyonce",
               grooveshark_id: 1234,
               nbs_id: 4321)
  end

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:metrics) }
  it { is_expected.to respond_to(:songs) }

  it { is_expected.to be_valid }

  describe "when name is not present" do
    before { artist.name = " " }
    it { is_expected.not_to be_valid }
  end

  describe "adding a new artist with duplicate attributes" do
    it "should be invalid if same name" do
      artist.save
      same_artist = artist.dup

      same_artist.name = artist.name.downcase
      same_artist.save

      expect(same_artist).not_to be_valid
    end

    it "should be invalid if same api ids" do
      artist.save
      same_artist = artist.dup

      same_artist.name = "Something Else"
      same_artist.grooveshark_id = 1234
      same_artist.nbs_id = 1234
      same_artist.save

      expect(same_artist).not_to be_valid

      same_artist.grooveshark_id = 4321
      same_artist.nbs_id = 4321
      same_artist.save

      expect(same_artist).not_to be_valid
    end
  end
end
