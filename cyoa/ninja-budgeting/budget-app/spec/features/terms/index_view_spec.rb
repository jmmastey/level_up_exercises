require 'rails_helper'

describe 'term index page' do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    page.set_rack_session(user_id: user.id)
  end

  it 'has terms table' do
    visit '/terms'
    expect(page).to have_selector('#terms-table')
  end

  it 'displays the list of terms for the user' do
    FactoryGirl.create(:term)
    visit '/terms'
    expect(page).to have_content('January')
    expect(page).to have_content('2015')
    expect(page).to have_content('$0.00')
  end

  it 'displays appropriate message if the user has no terms' do
    visit '/terms'
    expect(page).to have_content('You have no terms.')
  end

  it 'has a new-term button' do
    visit '/terms'
    expect(page).to have_selector('#new-term-button', visible: true)
  end

  it 'has a delete-term button' do
    FactoryGirl.create(:term)
    visit '/terms'
    expect(page).to have_selector('#delete-term-button')
  end

  it 'has available budget amounts', js: true do
    FactoryGirl.create(:term, options: { 'Test Category' => { budgeted_amount: { 1 => 5.00 }, amount_spent: 0.00 } })
    visit '/terms'
    expect(page).to have_content('January')
    expect(page).to have_content('2015')
    expect(page).to have_content('$5.00')
    find('#terms-table .expandable-category-row').click
    expect(page).to have_content('Test Category')
    expect(page).to have_selector('#restore-money-button')
  end
end
