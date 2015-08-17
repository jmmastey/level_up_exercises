require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe('#get_friends') do
    it 'should return all the friends for the current user' do
      user = create(:user)
      friend = create(:random_user)
      Friend.create(user: user, friend: friend)

      friends = Friend.get_friends(user)
      expect(friends.size).to be(1)
      expect(friends.first.friend).to eq(friend)
    end
  end
end
