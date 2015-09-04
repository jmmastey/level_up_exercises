require 'rails_helper'

describe 'funds index page' do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    page.set_rack_session(user_id: user.id)
  end

  it 'creates a fund and displays success message', js: true do
    visit '/funds'
    find('#new-fund-button').click
    page.find('#newFundModal').visible?
    within(:css, '#newFundModal') do
      fill_in('Name', with: 'Test Fund')
      fill_in('Amount', with: 10.32)
      select('Bank', from: 'fund[fund_type]')
    end
    click_button('Add Fund')
    expect(page).to have_content('Fund successfully added.')
    expect(page).to have_content('Test Fund')
    expect(page).to have_content('$10.32')
    find('#funds-table .expandable-category-row').click
    expect(page).to have_content('Available:')
  end

  it 'cannot create a fund and displays error message', js: true do
    FactoryGirl.create(:bank_fund)
    visit '/funds'
    find('#new-fund-button').click
    page.find('#newFundModal').visible?
    within(:css, '#newFundModal') do
      fill_in('Name', with: 'Bank Fund')
      fill_in('Amount', with: 10.32)
      select('Bank', from: 'fund[fund_type]')
    end
    click_button('Add Fund')
    expect(page).to have_content('Could not add fund.')
  end

  it 'can add money to one fund', js: true do
    FactoryGirl.create(:bank_fund)
    visit '/funds'
    find('#new-money-button').click
    page.find('#newMoneyModal').visible?
    within(:css, '#newMoneyModal') do
      fill_in('description', with: 'Testing Money Input')
      fill_in('amount', with: 34.56)
    end
    click_button('Submit')
    expect(page).to have_content('Successfully added money to fund.')
    expect(page).to have_content('$124.21')
    expect(page).to have_selector('#inputs-table tr', count: 2) # including header
    expect(page).to have_content(Time.now.strftime('%m/%d/%Y'))
    expect(page).to have_content('Testing Money Input')
  end
end
