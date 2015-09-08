require 'rails_helper'

describe 'Fund' do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:bank_fund)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:bank_fund, name: nil)).to_not be_valid
  end

  it 'is invalid without an amount' do
    expect(FactoryGirl.build(:bank_fund, amount: nil)).to_not be_valid
  end

  it 'is invalid without a user_id' do
    expect(FactoryGirl.build(:bank_fund, user_id: nil)).to_not be_valid
  end

  it 'does not allow duplicate funds by name for a user' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:bank_fund, amount: 9.38, user_id: user.id)
    expect(FactoryGirl.build(:bank_fund, amount: 10.38, user_id: user.id)).to_not be_valid
  end

  it 'allows duplicate funds by name for different users' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)
    FactoryGirl.create(:bank_fund, name: 'Test Fund', amount: 10.00, user_id: user.id)
    expect(FactoryGirl.build(:bank_fund, name: 'Test Fund', amount: 10.00, user_id: user2.id)).to be_valid
  end

  it 'only allows money format for amount' do
    expect(FactoryGirl.build(:bank_fund, name: 'Test Fund', amount: 'asd', user_id: 1)).to_not be_valid
    expect(FactoryGirl.build(:bank_fund, name: 'Test Fund', amount: '10.', user_id: 1)).to_not be_valid
    expect(FactoryGirl.build(:bank_fund, name: 'Test Fund', amount: '1.a3', user_id: 1)).to_not be_valid
  end
end
