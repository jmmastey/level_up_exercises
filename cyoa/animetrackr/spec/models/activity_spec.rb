require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe('#added?') do
    it 'should return true if the activity represents adding a new item' do
      activity = build(:new_activity)
      expect(activity.added?).to be(true)
    end

    it 'should return false if the activity does not represent adding a new item' do
      activity = build(:done_watching_activity)
      expect(activity.added?).to be(false)
    end
  end

  describe('#updated?') do
    it 'should return true if the activity represents updating an item' do
      activity = build(:currently_watching_activity)
      expect(activity.updated?).to be(true)
    end

    it 'should return false if the activity does not represent updating an item' do
      activity = build(:new_activity)
      expect(activity.updated?).to be(false)
    end
  end
end
