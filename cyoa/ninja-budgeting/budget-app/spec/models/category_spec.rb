require 'rails_helper'

describe 'Category' do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:category)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:category, name: nil)).to_not be_valid
  end

  it 'is invalid without a user_id' do
    expect(FactoryGirl.build(:category, user_id: nil)).to_not be_valid
  end

  it 'does not allow duplicate categories by name for a user' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:category, name: 'Test Category', user_id: user.id)
    expect(FactoryGirl.build(:category, name: 'Test Category', user_id: user.id)).to_not be_valid
  end

  it 'allows duplicate categories if the user_id is different' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)
    FactoryGirl.create(:category, name: 'Test Category', user_id: user.id)
    expect(FactoryGirl.build(:category, name: 'Test Category', user_id: user2.id)).to be_valid
  end
end
