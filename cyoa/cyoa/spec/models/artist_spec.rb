require 'spec_helper'

describe Artist do
  subject(:artist) { Artist.new(name: "Beyonce") }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is not present" do
    before { artist.name = " " }
    it { should_not be_valid }
  end

  describe "adding a new artist with same name" do
    it "should be invalid" do
      artist.save

      same_artist = artist.dup
      same_artist.name = artist.name.downcase
      same_artist.save

      expect(same_artist).not_to be_valid
    end
  end
end
