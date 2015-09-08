require 'rails_helper'

describe 'category index page' do
  context 'when logged out' do
    it 'redirects to home page' do
      page.set_rack_session(user_id: nil)
      visit '/categories'
      expect(page.current_path).to eq('/')
      expect(page).to have_content('Please log in first.')
    end
  end

  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      page.set_rack_session(user_id: user.id)
      visit '/categories'
    end

    it 'has categories table' do
      expect(page).to have_selector('.panel-body .table')
    end

    it 'displays appropriate message if user has no categories' do
      expect(page).to have_content('You have no categories.')
    end

    it 'has a new-category button' do
      expect(page).to have_selector('#new-category-button', visible: true)
    end

    describe 'user has categories' do
      before :all do
        FactoryGirl.create(:category)
      end

      before :each do
        visit '/categories'
      end

      after :all do
        Category.destroy_all
      end

      it 'displays the list of categories for the user' do
        expect(page).to have_content('Test Category')
      end

      it 'has an edit-category button' do
        expect(page).to have_selector('#edit-category-button')
      end

      it 'has a delete-category button' do
        expect(page).to have_selector('#delete-category-button')
      end
    end
  end
end
