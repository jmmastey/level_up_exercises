require 'rails_helper'

describe 'funds index page' do
  context 'when logged out' do
    it 'redirects to the home page' do
      page.set_rack_session(user_id: nil)
      visit '/funds'
      expect(page.current_path).to eq('/')
      expect(page).to have_content('Please log in first.')
    end
  end

  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      page.set_rack_session(user_id: user.id)
      visit '/funds'
    end

    describe 'funds-table' do
      it 'has add-fund button' do
        expect(page).to have_selector('#new-fund-button')
      end

      it 'says you have no funds if you have no funds' do
        expect(page).to have_content('You have no funds.')
      end

      it 'has a new-fund button' do
        expect(page).to have_selector('#new-fund-button', visible: true)
      end

      context 'when user has funds' do
        before :each do
          @fund1 = FactoryGirl.create(:bank_fund)
        end

        it 'has add-money button' do
          visit '/funds'
          expect(page).to have_selector('#new-money-button')
        end

        it 'shows your funds' do
          visit '/funds'
          expect(page).to have_selector('#funds-table tr', count: 2) # 2 including header
          expect(page).to have_content(@fund1.name)
          expect(page).to have_content(@fund1.amount)
        end

        it 'shows multiple funds if you have more than 1' do
          fund2 = FactoryGirl.create(:bank_fund, name: 'Test Fund 2', amount: 10.00)
          visit '/funds'
          expect(page).to have_selector('#funds-table tr', count: 3) # 3 including header
          expect(page).to have_content(@fund1.name)
          expect(page).to have_content(fund2.name)
          expect(page).to have_content(@fund1.amount)
          expect(page).to have_content(fund2.amount)
        end
      end
    end

    describe 'inputs-table' do
      before(:each) do
        @fund = FactoryGirl.create(:bank_fund)
      end

      it 'has no inputs in the table at the start' do
        visit '/funds'
        expect(page).to have_content('You have not added any additional money.')
        expect(page).to have_selector('#inputs-table tr', count: 2) # 2 including header
      end

      it 'has input data if input is submitted' do
        FactoryGirl.create(:input_transaction, amount: 10, fund_id: @fund.id)
        visit '/funds'
        expect(page).to have_content('Test Input Transaction')
        expect(page).to have_content('$10.00')
      end
    end
  end
end
