require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'is invalid without email' do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it 'is invalid without password' do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it 'is invalid with short password' do
    expect(FactoryGirl.build(:user, password: "pass")).to_not be_valid
  end
end
