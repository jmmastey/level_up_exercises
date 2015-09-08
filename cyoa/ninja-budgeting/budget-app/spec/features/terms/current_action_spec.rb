require 'rails_helper'

describe 'current term page actions' do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    page.set_rack_session(user_id: user.id)
    @fund = FactoryGirl.create(:bank_fund, amount: 1000, components: { 'Available' => 1000, 'Reserved' => {}, 'Pending' => {} })
    @category = FactoryGirl.create(:category, name: 'Test Category')
  end

  context 'user has no current term' do
    before :each do
      visit '/current'
    end

    it 'allows you to create a new current term if it doesn\'t exist' do
      expect(page).to have_content('Create one now?')
      find('#create-new-current-term').click
      page.find('#newCurrentTermModal').visible?
      within(:css, '#newCurrentTermModal') do
        # All categories selected
        click_button('Create Term')
      end
      expect(page).to have_content('Term successfully created.')
      expect(page).to have_selector('#transactions-table')
      expect(page).to have_content("#{Date::MONTHNAMES[Time.now.month]} #{Time.now.year}")
      expect(page).to have_content('Test Category')
      expect(page).to have_content('$0.00')
      expect(page).to have_content('You have no transactions for this month.')
      expect(page).to have_selector('#new-transaction-button')
    end
  end

  context 'user has current term' do
    before :each do
      @term = FactoryGirl.create(:term, month: Time.now.month, year: Time.now.year, options: { @category.name => { budgeted_amount: {}, amount_spent: 0.0 } })
      visit '/current'
    end

    it 'allows user to add money to budgeted category', js: true do
      click_link(@category.name)
      page.find('#addMoneyTermCategoryModal').visible?
      within(:css, '#addMoneyTermCategoryModal') do
        fill_in(@fund.name, with: 100)
        click_button('Done')
      end
      expect(page).to have_content('$100.00')

      # Check that fund has that reserved amount
      visit '/funds'
      expect(page).to have_content(@fund.name)
      find('#funds-table .expandable-category-row').click
      expect(page).to have_content("Reserved: #{Date::MONTHNAMES[Time.now.month]} #{Time.now.year}")
      expect(page).to have_content('$1000.00')
      expect(page).to have_content('$900.00')
      expect(page).to have_content('$100.00')
    end

    it 'allows user to add transaction', js: true do
      # Add money to category first
      click_link(@category.name)
      page.find('#addMoneyTermCategoryModal').visible?
      within(:css, '#addMoneyTermCategoryModal') do
        fill_in(@fund.name, with: 100)
        click_button('Done')
      end
      expect(page).to have_content('$100.00')

      find('#new-transaction-button').click
      page.find('#newTransactionModal').visible?
      within(:css, '#newTransactionModal') do
        fill_in('Amount', with: 25.00)
        select('Test Category', from: 'Category')
        select(@fund.name, from: 'Payment Method')
        click_button('Add Expense')
      end
      expect(page).to have_content('Successfully created transaction.')
      expect(page).to have_content("#{Time.now.strftime('%m/%d')}")
      expect(page).to have_content('$25.00')
      expect(page).to have_content(@fund.name)
      expect(page).to have_content('No')
      expect(page).to have_content('$75.00')

      # Check that fund has that pending amount
      visit '/funds'
      expect(page).to have_content(@fund.name)
      find('#funds-table .expandable-category-row').click
      expect(page).to have_content("Pending: #{Date::MONTHNAMES[Time.now.month]} #{Time.now.year}")
      expect(page).to have_content('$25.00')
    end

    it 'can change paid status and update fund', js: true do
      # Add money to category first
      click_link(@category.name)
      page.find('#addMoneyTermCategoryModal').visible?
      within(:css, '#addMoneyTermCategoryModal') do
        fill_in(@fund.name, with: 100)
        click_button('Done')
      end
      expect(page).to have_content('$100.00')

      find('#new-transaction-button').click
      page.find('#newTransactionModal').visible?
      within(:css, '#newTransactionModal') do
        fill_in('Amount', with: 25.00)
        select('Test Category', from: 'Category')
        select(@fund.name, from: 'Payment Method')
        click_button('Add Expense')
      end
      expect(page).to have_content('Successfully created transaction.')
      expect(page).to have_content('No')

      # Change paid status and check fund amounts
      click_link('No')
      expect(page).to_not have_content('No')
      visit '/funds'
      find('#funds-table .expandable-category-row').click
      expect(page).to_not have_content("Pending: #{Date::MONTHNAMES[Time.now.month]} #{Time.now.year}")
      expect(page).to have_content('$975.00')
      expect(page).to have_content('$900.00')
      expect(page).to have_content('$75.00')
    end
  end
end
