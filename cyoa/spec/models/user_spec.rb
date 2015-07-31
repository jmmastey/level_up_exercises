require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "has a unique email" do
    FactoryGirl.create(:user, email: "1@email.com")
    FactoryGirl.create(:user, email: "2@email.com")
    FactoryGirl.create(:user, email: "3@email.com")
    expected = expect do
      FactoryGirl.create(:user, email: "1@email.com")
    end
    expected.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "can share it's full name" do
    user = FactoryGirl.build(:user, first_name: "Test", last_name: "User")
    expect(user.full_name).to eq("Test User")

    user = FactoryGirl.build(:user, first_name: " ", last_name: "User")
    expect(user.full_name).to eq("User")

    user = FactoryGirl.build(:user, first_name: "Test", last_name: "")
    expect(user.full_name).to eq("Test")

    user = FactoryGirl.build(:user, first_name: "    ", last_name: nil)
    expect(user.full_name).to eq("")
  end
end
