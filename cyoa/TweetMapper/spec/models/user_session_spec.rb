require 'rails_helper'

RSpec.describe UserSession, type: :model do
  it 'has a valid factory' do
    user_session = create(:user_session)
    expect(user_session).to be_valid
  end
  it 'is invalid without a session_key' do
    user_session = build(:user_session, session_key: nil)
    expect(user_session).not_to be_valid
  end
  it 'is invalid without a unique session_key' do
    session_key = Faker::Lorem.characters(40)
    user_session1 = create(:user_session, session_key: session_key)
    user_session2 = build(:user_session, session_key: session_key)
    expect(user_session1).to be_valid
    expect(user_session2).not_to be_valid
  end
  it 'is invalid without a latitude' do
    user_session = build(:user_session, latitude: nil)
    expect(user_session).not_to be_valid
  end
  it 'is invalid without a longitude' do
    user_session = build(:user_session, longitude: nil)
    expect(user_session).not_to be_valid
  end
  it 'is invalid without a miles_radius' do
    user_session = build(:user_session, miles_radius: nil)
    expect(user_session).not_to be_valid
  end
end
