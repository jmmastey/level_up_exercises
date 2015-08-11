require 'rails_helper'

describe User, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:user) { build(:user) }

      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'with invalid attributes' do
      context 'with invalid email' do
        let(:user) { build(:user, email: 'bogus') }

        it 'is invalid' do
          expect(user).to_not be_valid
        end
      end

      context 'with duplicate email' do
        before do
          create(:user, email: 'test@test.com')
          @user_2 = build(:user, email: 'test@test.com')
        end

        it 'is invalid' do
          expect(@user_2).to_not be_valid
        end
      end

      context 'with bogus zipcode' do
        let(:user) { build(:user, zipcode: 'abcde') }

        it 'is invalid' do
          user.save
          expect(user).to_not be_valid
        end
      end

      context 'with zipcode that does not match a city' do
        let(:user) { build(:user, zipcode: '99999') }

        it 'is invalid' do
          user.save
          expect(user).to_not be_valid
        end
      end
    end
  end

  describe '#legislators_by_zipcode' do
    context 'with a zipcode' do
      before do
        @user = create(:user, zipcode: '60607')
        district_id = 1
        create(:congressional_district, zipcode: '60607', state: 'IL',
                                        congressional_district_id: district_id)
        @legislator = create(:legislator, state: 'IL', district: district_id)
      end

      it 'finds the legislators for the user zipcode' do
        expect(@user.legislators_by_zipcode).to contain_exactly(@legislator)
      end
    end

    context 'with no zipcode' do
      let(:user) { build(:user, zipcode: nil) }

      it 'returns an empty array' do
        expect(user.legislators_by_zipcode).to eq([])
      end
    end
  end
end
