require 'rails_helper'

describe UserTag, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:user_tag) { create(:user_tag, user_id: 1, tag_id: 3) }

      it 'is valid' do
        expect(user_tag).to be_valid
      end
    end

    context 'with invalid attributes' do
      before do
        create(:user_tag, user_id: 1, tag_id: 3)
        @user_tag_2 = build(:user_tag, user_id: 1, tag_id: 3)
      end

      it 'is not valid' do
        expect(@user_tag_2).to_not be_valid
      end
    end
  end
end
