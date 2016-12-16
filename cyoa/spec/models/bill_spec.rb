require 'rails_helper'

describe Bill, type: :model do
  describe '#initialize' do
    context 'valid' do
      let(:bill) { build(:bill) }

      it 'is valid with default attributes' do
        expect(bill).to be_valid
      end
    end

    context 'invalid' do
      before do
        create(:bill, bill_id: 'hr1234')
        @bill_2 = build(:bill, bill_id: 'hr1234')
      end

      it 'is invalid with duplicate bill id' do
        expect(@bill_2).to_not be_valid
      end
    end
  end

  describe '#type_and_num' do
    let(:bill_1) { build(:bill, bill_id: 'hr123-114', bill_type: 'hr') }
    let(:bill_2) { build(:bill, bill_id: 'sconres91231-114', bill_type: 'sconres') }
    let(:bill_3) { build(:bill, bill_id: 'hjres7-114', bill_type: 'hjres') }

    it 'creates a better bill title' do
      expect(bill_1.type_and_num).to eq('H.R. 123')
      expect(bill_2.type_and_num).to eq('S.Con.Res. 91231')
      expect(bill_3.type_and_num).to eq('H.J.Res. 7')
    end
  end
end
