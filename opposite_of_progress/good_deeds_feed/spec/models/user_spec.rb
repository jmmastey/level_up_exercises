require 'rails_helper'

# I have left out tests for security/login/authentication methods
# in the user model

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.create(:user) }
  let(:legislator) { FactoryGirl.create(:legislator) }
  describe "#favorite_legislator" do
    it "adds legislator to user favorites" do
      expect(user.legislators.count).to eq(0)
      expect { user.favorite_legislator(legislator) }.to \
        change { user.legislators.count }.by(1)
    end

    it "does nothing is the legislator is already added to favorites" do
      user.favorite_legislator(legislator)
      expect { user.favorite_legislator(legislator) }.not_to \
        change { user.legislators.count }
    end
  end

  describe "#following_legislator?" do
    it "returns true if user is following the legislator" do
      user.favorite_legislator(legislator)
      expect(user.following_legislator?(legislator)).to eq(true)
    end

    it "returns false if user is not following the legislator" do
      expect(user.following_legislator?(legislator)).to eq(false)
    end
  end

  describe "#self.digest" do
    it "generates a 60 character string" do
      expect(User.digest("password")).to be_a(String)
      expect(User.digest("password").length).to be(60)
    end

    it "is generates a new random string for the same input" do
      expect(User.digest("password")).not_to eq(User.digest("password"))
    end
  end

  describe "#self.new_token" do
    it "generates a 22 character string" do
      expect(User.new_token).to be_a(String)
      expect(User.new_token.length).to be(22)
    end

    it "is generates a new random string for the same input" do
      expect(User.new_token).not_to eq(User.new_token)
    end
  end

  describe "#remember" do
    it "creates a remember token for users" do
      expect(user.remember_digest).to eq(nil)
      user.remember
      expect(user.remember_digest).not_to eq(nil)
    end
  end

  describe "#forget" do
    it "deletes the user's remember token" do
      user.remember
      user.forget
      expect(user.remember_digest).to eq(nil)
    end
  end
end