require 'rails_helper'

describe Deck do
  it "has a valid factory" do
    expect(create(:deck)).to be_valid
  end

  it "is invalid without a user" do
    expect(build(:deck, user: nil)).to_not be_valid
  end

  it "is invalid without a name" do
    expect(build(:deck, name: nil)).to_not be_valid
  end
end
