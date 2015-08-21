require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without a username" do
    expect(build(:user, username: nil)).to_not be_valid
  end

  it "does not allow duplicate usernames" do
    user = create(:user)
    expect(build(:user, username: user.username)).to_not be_valid
  end

  it "is invalid with usernames longer than 50 characters" do
    expect(build(:user, username: "a" * 51)).to_not be_valid
  end

  it "is invalid without a password" do
    expect(build(:user, password: nil)).to_not be_valid
  end

  it "is invalid with passwords less than 6 characters" do
    expect(build(:user, password: "p" * 5)).to_not be_valid
  end

  it "is invalid with passwords longer than 255 characters" do
    expect(build(:user, password: "p" * 256)).to_not be_valid
  end

  it "is invalid without an email" do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it "does not allow duplicate emails" do
    user = create(:user)
    expect(build(:user, email: user.email)).to_not be_valid
  end

  it "is invalid with invalid emails" do
    expect(build(:user, email: "not valid")).to_not be_valid
  end

  it "is invalid with emails longer than 255 characters" do
    expect(build(:user, email: "e" * 256)).to_not be_valid
  end
end
