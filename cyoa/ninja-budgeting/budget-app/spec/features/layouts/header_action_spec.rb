require 'rails_helper'

describe 'header actions' do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    page.set_rack_session(user_id: user.id)
    visit '/dashboard'
  end

  it 'successfully navigates to the category index page' do
    click_link('Categories')
    expect(page.current_path).to eq('/categories')
  end

  it 'successfully navigates to the term index page' do
    click_link('Terms')
    expect(page.current_path).to eq('/terms')
  end

  it 'successfully navigates to the fund index page' do
    click_link('Funds')
    expect(page.current_path).to eq('/funds')
  end

  it 'successfully navigates to the current month details page' do
    click_link('Current Month')
    expect(page.current_path).to eq('/current')
  end

  it 'successfully navigates to the next month details page' do
    click_link('Next Month')
    expect(page.current_path).to eq('/next')
  end
end
