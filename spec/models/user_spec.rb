require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "Create new user" do

    it "validates a new valid user" do
      user = User.new
      user.first_name = "Paul"
      user.last_name = "Haddad"
      user.email = "paul@example.com"
      user.password = "secret"
      user.password_confirmation = "secret"

      expect(user).to be_valid
    end

    it "does not validate a new invalid user" do
      user = User.new
      user.first_name = ""
      user.last_name = ""
      user.email = "haddad"
      user.password = ""
      user.password_confirmation = ""

      user.valid?

      expect(user).not_to be_valid
    end

    it "does not validate a new invalid user when passwords don't match" do
      user = User.new
      user.first_name = "Paul"
      user.last_name = "Haddad"
      user.email = "paul@example.com"
      user.password = "secret1"
      user.password_confirmation = "secret2"

      user.valid?

      expect(user).not_to be_valid
    end

    it "does not validate a user with an invalid email address" do
      user = User.new
      user.first_name = "Paul"
      user.last_name = "Haddad"
      user.email = "paul"
      user.password = "secret"
      user.password_confirmation = "secret"

      expect(user).not_to be_valid
    end

    it "creates a non-admin user by default" do
      user = User.create(email: "paul@example.com", password: "secret1", password_confirmation: "secret2")

      expect(user.admin?).to be false
    end

    describe "validations" do

      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:password) }
    end

    describe "associations" do
      let(:user) { create(:user) }
      let(:artist) { create(:artist) }

      it "has favorite artists" do
        user.favorite_artists << artist

        expect(user.favorite_artists.size).to eq(1)
      end

      it { should have_many(:favorites) }
      it { should have_many(:favorite_artists) }
    end

    describe "#full_name" do
      let(:user) { create(:user, first_name: "Paul", last_name: "Haddad") }

      it "returns the first and last names concatenated" do
        full_name = user.full_name

        expect(full_name).to eq("Paul Haddad")
      end
    end

    describe "#sample_artworks" do
      let(:user) { create(:user) }
      let(:artist_1) { create(:artist, first_name: "Artist",  last_name: "One") }
      let(:artist_2) { create(:artist, first_name: "Artist",  last_name: "Two") }
      let(:artist_3) { create(:artist, first_name: "Artist",  last_name: "Three") }

      it "returns one sample artwork from each favorite artist" do
        user.favorite_artists << artist_1
        user.favorite_artists << artist_2
        user.favorite_artists << artist_3

        sample_artworks = user.sample_artworks

        expect(sample_artworks.size).to eq(3)
      end
    end
  end
end
