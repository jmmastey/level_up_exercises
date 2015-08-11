require 'rails_helper'

describe Tag, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:tag) { build(:tag, name: 'Agriculture') }

      it 'is valid' do
        expect(tag).to be_valid
      end
    end
  end
end
