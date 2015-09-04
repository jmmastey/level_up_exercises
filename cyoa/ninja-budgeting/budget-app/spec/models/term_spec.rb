require 'rails_helper'

describe 'Term' do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:term)).to be_valid
  end

  it 'is invalid without a month' do
    expect(FactoryGirl.build(:term, month: nil)).to_not be_valid
  end

  it 'is invalid without a year' do
    expect(FactoryGirl.build(:term, year: nil)).to_not be_valid
  end

  it 'is invalid without a user_id' do
    expect(FactoryGirl.build(:term, user_id: nil)).to_not be_valid
  end

  it 'does not allow duplicate terms (by month and year) for a user' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:term, month: 1, year: 1, user_id: user.id)
    expect(FactoryGirl.build(:term, month: 1, year: 1, user_id: user.id)).to_not be_valid
  end

  it 'allows duplicate terms (by month and year) for different users' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)
    FactoryGirl.create(:term, month: 1, year: 1, user_id: user.id)
    expect(FactoryGirl.build(:term, month: 1, year: 1, user_id: user2.id)).to be_valid
  end
end
