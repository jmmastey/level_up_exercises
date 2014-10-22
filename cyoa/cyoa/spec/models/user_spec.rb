require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }
  let(:beyonce) { Artist.yonce }
  let(:xxyyxx) { xxyyxx = Artist.find_or_create_by_unique_name("xxyyxx") }
  let(:not_an_artist) { asdf = Artist.find_or_create_by_unique_name("asdfsjkfhsdkjsfsr") }

  it { is_expected.to be_valid }

  describe "#artists" do
    it { is_expected.to respond_to(:artists) }

    it "has default artists on creation" do
      expect(user.artists).to include(beyonce)
    end
  end

  describe "#remove_artist" do
    it "can remove artists" do
      user.remove_artist(beyonce)
      expect(user.artists).not_to include(beyonce)
    end
  end

  describe "#add_artist" do
    it "can add a new artist" do
      user.add_artist(xxyyxx)
      expect(user.artists).to include(xxyxx)
    end
  end

  describe "#nbs_artists" do
    it "returns only artists w/ a nbs_id" do
      user.add_artist(not_an_artist)
      user.add_artist(xxyyxx)
      expect(user.nbs_artists).to include(xxyxx)
      expect(user.nbs_artists).not_to include(not_an_artist)
    end
  end
end
