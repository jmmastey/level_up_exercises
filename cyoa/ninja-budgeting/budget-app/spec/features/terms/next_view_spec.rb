require 'rails_helper'

describe 'next term page' do
  context 'when logged out' do
    it 'redirects to home page' do
      page.set_rack_session(user_id: nil)
      visit '/current'
      expect(page.current_path).to eq('/')
      expect(page).to have_content('Please log in first.')
    end
  end

  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      page.set_rack_session(user_id: user.id)
      @fund = FactoryGirl.create(:bank_fund, amount: 1000)
      @category = FactoryGirl.create(:category, name: 'Test Category')
      visit '/next'
    end

    it 'displays correct text if term does not exist' do
      expect(page).to have_content('You have not created a budget for next month.')
      expect(page).to have_content('Create one now?')
      expect(page).to have_selector('#create-new-next-term')
    end

    it 'displays the term if it exists' do
      @term = FactoryGirl.create(:term, month: (Time.now + 1.month).month, year: (Time.now + 1.month).year, options: { @category.name => { budgeted_amount: {}, amount_spent: 0.0 } })
      visit '/next'
      expect(page).to have_selector('#transactions-table')
      expect(page).to have_content("#{Date::MONTHNAMES[(Time.now + 1.month).month]} #{(Time.now + 1.month).year}")
      expect(page).to have_content('Test Category')
      expect(page).to have_content('$0.00')
      expect(page).to have_content('You have no transactions for this month.')
      expect(page).to have_selector('#new-transaction-button')
      find_link(@category.name).visible?
    end
  end
end
