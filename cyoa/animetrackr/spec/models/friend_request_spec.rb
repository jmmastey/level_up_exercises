require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe('#create') do
    it 'should not allow the same user for both ends' do
      user = create(:random_user)
      expect(FriendRequest.create(from: user, to: user)).not_to be_valid
    end

    it 'should not allow duplicates' do
      user = create(:random_user)
      friend = create(:random_user)

      FriendRequest.create(from: user, to: friend)
      expect(FriendRequest.create(from: user, to: friend)).not_to be_valid
    end
  end

  describe('#get_pending') do
    it 'should return the pending request for the user' do
      user = create(:random_user)
      friend = create(:random_user)
      FriendRequest.create(from: user, to: friend)

      pending = FriendRequest.get_pending(user)
      expect(pending.size).to be(1)
      expect(pending.first.to).to eq(friend)
    end
  end

  describe('#get_requests') do
    it 'should return the pending invitations to the user' do
      user = create(:random_user)
      friend = create(:random_user)
      FriendRequest.create(from: friend, to: user)

      requests = FriendRequest.get_requests(user)
      expect(requests.size).to be(1)
      expect(requests.first.from).to eq(friend)
      expect(requests.first.to).to eq(user)
    end
  end
end
