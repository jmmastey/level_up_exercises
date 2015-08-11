require 'rails_helper'

describe UserBill, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:user_bill) { create(:user_bill, bill_id: 1, user_id: 3) }

      it 'is valid' do
        expect(user_bill).to be_valid
      end
    end

    context 'with invalid attributes' do
      before do
        create(:user_bill, bill_id: 1, user_id: 3)
        @user_bill_2 = build(:user_bill, bill_id: 1, user_id: 3)
      end

      it 'is not valid' do
        expect(@user_bill_2).to_not be_valid
      end
    end
  end
end
