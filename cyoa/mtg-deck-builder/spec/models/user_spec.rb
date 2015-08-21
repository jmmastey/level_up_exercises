require 'rails_helper'

def generate_decks(user)
  rand(2..20).times { create(:deck, user: user) }
end

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

  it "can create a deck" do
    user = create(:user)
    create(:deck, user: user)
    expect(user.decks).to_not be_empty
  end

  it "can create multiple decks" do
    user = create(:user)
    n_decks = generate_decks(user)
    expect(user.decks.count).to eq(n_decks)
  end

  it "has all of its decks destroyed when it itself is destroyed" do
    user = create(:user)
    generate_decks(user)
    deck_ids = user.decks.map(&:id)
    user.destroy
    expect(Deck.where(id: deck_ids)).to be_empty
  end
end
