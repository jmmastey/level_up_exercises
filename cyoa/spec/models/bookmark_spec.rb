require 'rails_helper'

describe Bookmark, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:bookmark) { create(:bookmark, bill_id: 1, user_id: 3) }

      it 'is valid' do
        expect(bookmark).to be_valid
      end
    end

    context 'with invalid attributes' do
      before do
        create(:bookmark, bill_id: 1, user_id: 3)
        @bookmark_2 = build(:bookmark, bill_id: 1, user_id: 3)
      end

      it 'is not valid' do
        expect(@bookmark_2).to_not be_valid
      end
    end
  end
end
