require 'rails_helper'

describe 'terms index page' do
  before do
    @user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: @user.id)
  end

  it 'creates a term and displays success message' do
    visit '/terms'
    find('#new-term-button').click
    page.find('#newTermModal').visible?
    select('January', from: 'Month')
    select(Time.now.year, from: 'Year')
    click_button('Create Term')
    expect(page).to have_content('Term successfully created.')
    expect(page).to have_content('January')
    expect(page).to have_content(Time.now.year)
  end

  it 'cannot create a term and displays error message' do
    FactoryGirl.create(:term)
    visit '/terms'
    find('#new-term-button').click
    page.find('#newTermModal').visible?
    select('January', from: 'Month')
    select(Time.now.year, from: 'Year')
    click_button('Create Term')
    expect(page).to have_content('Could not create term.')
  end

  it 'allows you to delete your term', js: true do
    FactoryGirl.create(:term)
    visit '/terms'
    find('#delete-term-button').click
    page.find('#deleteTermModal').visible?
    click_button('Delete')
    expect(page).to have_content('Successfully deleted term.')
    expect(page).to have_selector('table tr', count: 2) # including header row
  end

  it 'allows you to transfer money back to fund', js: true do
    # First, create a fund
    fund = FactoryGirl.create(:bank_fund, amount: 100.00)

    # Second, create a category
    FactoryGirl.create(:category, name: 'Test Category')

    # Third, create a term
    visit '/terms'
    find('#new-term-button').click
    page.find('#newTermModal').visible?
    select('January', from: 'Month')
    select(Time.now.year, from: 'Year')
    click_button('Create Term')
    expect(page).to have_content('Term successfully created.')
    expect(page).to have_content('January')
    expect(page).to have_content(Time.now.year)

    # Now, go to that term page and add money to the category.
    expect(page).to have_selector('#view-term-button')
    click_link('view-term-button')
    expect(page).to have_selector('#transactions-table')
    click_link('Test Category')
    page.find('#addMoneyTermCategoryModal').visible?
    within(:css, '#addMoneyTermCategoryModal') do
      fill_in(fund.name, with: 50.00)
      click_button('Done')
    end
    expect(page).to have_content('$50.00')

    # Finally, go back to the terms page
    visit '/terms'
    find('#terms-table .expandable-category-row').click
    expect(page).to have_content('Test Category')
    expect(page).to have_content('$50.00')
    expect(page).to have_selector('#restore-money-button')
    find('#restore-money-button').click
    
    expect(page).to have_content('Money successfully transferred.')
    expect(page).to have_content('$0.00')
    expect(page).to_not have_content('Test Category')
  end
end
