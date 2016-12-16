require 'rails_helper'

describe BillTag, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:bill_tag) { create(:bill_tag, bill_id: 1, tag_id: 3) }

      it 'is valid' do
        expect(bill_tag).to be_valid
      end
    end

    context 'with invalid attributes' do
      before do
        create(:bill_tag, bill_id: 1, tag_id: 3)
        @bill_tag_2 = build(:bill_tag, bill_id: 1, tag_id: 3)
      end

      it 'is not valid' do
        expect(@bill_tag_2).to_not be_valid
      end
    end
  end
end
