require 'spec_helper'

describe User do

  let(:valid_user) { user = User.create(name: "Kevin Kline") }
  let(:blank_user) { user = User.create(name: "") }

  it "responds to name" do
    expect(valid_user).to respond_to(:name)
  end

  it "is valid when proper name supplied" do
    expect(valid_user).to be_valid
  end

  it "is invalid when blank name supplied" do
    expect(blank_user).to be_invalid
  end

end
