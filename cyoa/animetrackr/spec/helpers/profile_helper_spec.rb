require 'rails_helper'
require 'digest'

RSpec.describe ProfileHelper, type: :helper do
  describe('#gravatar_for') do
    it 'should return a gravatar url for user email' do
      email = 'test@example.com'
      gravatar_url = 'https://www.gravatar.com/avatar/' +
                     Digest::MD5.hexdigest(email)

      expect(gravatar_for('test@example.com')).to eq(gravatar_url)
    end
  end

  describe('#member_since') do
    it 'should return the join date in a formatted date' do
      format_regex = /Member Since: \d{2}-\d{2}-\d{4}/
      expect(member_since(Time.now)).to match(format_regex)
    end
  end

  describe('#anime_wishlist') do
    it 'should return all items in the wishlist when passed 1 argument' do
      user = create(:user)
      user.library_items.create(
        anime: create(:anime),
        user: user,
        view_status: 'Wishlist',
      )

      expect(anime_wishlist(user).size).to eq(1)
    end

    it 'should return a subset of the wishlist when passed in 2 arguments' do
      user = create(:user)
      5.times do
        user.library_items.create(
          anime: create(:anime),
          user: user,
          view_status: 'Wishlist',
        )
      end

      expect(anime_wishlist(user, 3).size).to eq(3)
    end
  end

  describe('#anime_currently_watching') do
    it 'should return all items currently watching when passed 1 argument' do
      user = create(:user)
      3.times do
        user.library_items.create(
          anime: create(:anime),
          user: user,
          view_status: 'Currently Watching',
        )
      end

      expect(anime_currently_watching(user).size).to be(3)
    end

    it 'should return subset of currently watching items when passed 2 args' do
      user = create(:user)
      5.times do
        user.library_items.create(
          anime: create(:anime),
          user: user,
          view_status: 'Currently Watching',
        )
      end

      expect(anime_currently_watching(user, 2).size).to be(2)
    end
  end

  describe('#anime_done_watching') do
    it 'should return all items done watching when passed 1 argument' do
      user = create(:user)
      3.times do
        user.library_items.create(
          anime: create(:anime),
          user: user,
          view_status: 'Done',
        )
      end

      expect(anime_done_watching(user).size).to be(3)
    end

    it 'should return subset of done watching items when passed 2 args' do
      user = create(:user)
      5.times do
        user.library_items.create(
          anime: create(:anime),
          user: user,
          view_status: 'Done',
        )
      end

      expect(anime_done_watching(user, 2).size).to be(2)
    end
  end
end
