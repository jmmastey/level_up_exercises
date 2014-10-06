require 'spec_helper'

describe Song do
  let(:artist) { FactoryGirl.create(:artist) }
  let(:song_name) { "Single Ladies" }
  let(:song) { artist.songs.build(name: song_name) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:artist) }
  it { is_expected.to respond_to(:charts) }

  describe "#name" do
    it "when song doesn't have a name it should not be valid" do
      song.name = " "
      expect(song).not_to be_valid
    end

    context "when artist already has a song by that name" do
      it "should not be valid" do
        song.save
        same_song = song.dup
        same_song.name = song.name.downcase
        same_song.save

        expect(same_song).not_to be_valid
      end
    end
  end

  describe "#artist" do
    it "when artist isn't present should not be valid" do
      song.artist = nil
      expect(song).not_to be_valid
    end

    it "knows its artist" do
      song.save
      expect(song.artist).to eq artist
    end
  end
end
