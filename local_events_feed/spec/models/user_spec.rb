require 'spec_helper'

describe User do

  let(:valid_user) { User.create(name: "Kevin Kline", email: "coolguy@besthost.com") }
  let(:blank_user) { User.create(name: "") }
  let(:duplicate_email_user) { User.create(name: "John Ritter", email: "coolguy@besthost.com") }

  it "responds to name" do
    expect(valid_user).to respond_to(:name)
  end

  it "responds to email" do
    expect(valid_user).to respond_to(:email)
  end

  it "is valid when proper name supplied" do
    expect(valid_user).to be_valid
  end

  it "is invalid when blank name supplied" do
    expect(blank_user).to be_invalid
  end

  it "will not create a user with an email that already exists" do
    valid_user
    expect(duplicate_email_user).to be_invalid
  end
end
