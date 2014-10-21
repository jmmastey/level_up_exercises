require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  it { is_expected.to be_valid }

  describe "#artists" do
    it { is_expected.to respond_to(:artists) }

    it "has default artists on creation" do
      expect(user.artists).to include(Artist.yonce)
    end
  end


end
