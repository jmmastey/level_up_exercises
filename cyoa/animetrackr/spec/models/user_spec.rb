require 'rails_helper'

RSpec.describe User, type: :model do
  let(:current_username) { 'test_user' }

  describe('.find_public_users') do
    it 'should return user matching username if user is public' do
      user = create(:user)
      results = User.find_public_users(user.username, current_username)
      expect(results.size).to eq(1)
      expect(results.first).to eq(user)
    end

    it 'should return an empty set if no users are found' do
      results = User.find_public_users('none_existant', current_username)
      expect(results.empty?).to be(true)
    end

    it 'should not return a user if user is private' do
      user = create(:private_user)
      results = User.find_public_users(user.username, current_username)
      expect(results.empty?).to be(true)
    end

    it 'should not return the current user' do
      user = create(:user)
      results = User.find_public_users(user.username, user.username)
      expect(results.empty?).to be(true)
    end
  end
end
