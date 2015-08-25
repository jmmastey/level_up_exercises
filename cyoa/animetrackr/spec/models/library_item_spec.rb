require 'rails_helper'

RSpec.describe LibraryItem, type: :model do
  let(:wishlist) do
    user = create(:user)
    anime = create(:anime)
    user.library_items.create(
      anime: anime,
      user: user,
      view_status: 'Wishlist',
    )
    user
  end

  let(:currently_watching) do
    user = create(:user)
    anime = create(:anime)
    user.library_items.create(
      anime: anime,
      user: user,
      view_status: 'Currently Watching',
    )
    user
  end

  let(:done_watching) do
    user = create(:user)
    anime = create(:anime)
    user.library_items.create(
      anime: anime,
      user: user,
      view_status: 'Done',
    )
    user
  end

  describe('#wishlist?') do
    it 'should return true if the view status is wishlist' do
      expect(wishlist.library_items.first.wishlist?).to be(true)
    end

    it 'should return false if the view status is not wishlist' do
      wishlist = currently_watching.library_items.first.wishlist?
      expect(wishlist).to be(false)
    end
  end

  describe('#currently_watching?') do
    it 'should return true if the view status is currently watching' do
      watching = currently_watching.library_items.first.currently_watching?
      expect(watching).to be(true)
    end

    it 'should return false if the view status is not currently watching' do
      expect(wishlist.library_items.first.currently_watching?).to be(false)
    end
  end

  describe('#done_watching?') do
    it 'should return true if the view status is done' do
      expect(done_watching.library_items.first.done_watching?).to be(true)
    end

    it 'should return false if the view status is not done' do
      expect(wishlist.library_items.first.done_watching?).to be(false)
    end
  end
end
