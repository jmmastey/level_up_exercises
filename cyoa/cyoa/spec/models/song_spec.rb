require 'spec_helper'

describe Song do
  let(:artist) { FactoryGirl.create(:artist) }
  let(:song) { artist.songs.build(name: "Single Ladies") }

  it { should respond_to(:name) }
  it { should respond_to(:artist_id) }
  its(:artist) { should eq artist }

  describe "when song doesn't have a name" do
    it "should not be valid" do
      song.name = " "
      expect(song).not_to be_valid
    end
  end

  describe "when artist isn't present" do
    it "should not be valid" do
      song.artist = nil
      expect(song).not_to be_valid
    end
  end

  describe "when artist already has a song by that name" do
    it "should not be valid" do
      song.save
      same_song = song.dup
      same_song.name = song.name
      same_song.save

      expect(same_song).not_to be_valid
    end
  end
end
