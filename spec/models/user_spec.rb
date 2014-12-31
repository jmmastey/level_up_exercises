require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "Create new user" do

    it "validates a new valid user" do
      user = User.new
      user.email = "paul@example.com"
      user.password = "secret"
      user.password_confirmation = "secret"

      expect(user).to be_valid
    end

    it "does not validate a new invalid user" do
      user = User.new
      user.email = "haddad"
      user.password = ""
      user.password_confirmation = ""

      user.valid?

      expect(user).not_to be_valid
    end

    it "does not validate a new invalid user when passwords don't match" do
      user = User.new
      user.email = "paul@example.com"
      user.password = "secret1"
      user.password_confirmation = "secret2"

      user.valid?

      expect(user).not_to be_valid
    end

    it "does not validate a user with an invalid email address" do
      user = User.new
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

      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:password) }
    end
  end
end
