require 'rails_helper'

describe 'header' do
  context 'when logged out' do
    it 'redirects to home page' do
      page.set_rack_session(user_id: nil)
      visit '/dashboard'
      expect(page.current_path).to eq('/')
      expect(page).to have_content('Please log in first.')
    end
  end

  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      page.set_rack_session(user_id: user.id)
      visit '/dashboard'
    end

    it 'has a sign-out button' do
      expect(page).to have_selector('#sign-out-button', visible: true)
    end

    it 'has a category management button' do
      expect(page).to have_selector('#category-management-button', visible: true)
    end

    it 'has a term management button' do
      expect(page).to have_selector('#term-management-button', visible: true)
    end

    it 'has a fund management button' do
      expect(page).to have_selector('#fund-management-button', visible: true)
    end

    it 'has a current month budget button' do
      expect(page).to have_selector('#current-month-details-button', visible: true)
    end

    it 'has a next month budget button' do
      expect(page).to have_selector('#next-month-details-button', visible: true)
    end
  end
end
