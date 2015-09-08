require 'rails_helper'

describe 'categories index page' do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    page.set_rack_session(user_id: user.id)
  end

  it 'creates a category and displays success message' do
    visit '/categories'
    expect(page).to have_selector('table tr', count: 2) # including header row
    find('#new-category-button').click
    page.find('#newCategoryModal').visible?
    within(:css, '#newCategoryModal') do
      fill_in('Name', with: 'Test Category')
    end
    click_button('Create Category')
    expect(page).to have_selector('table tr', count: 2) # including header row
    expect(page).to have_content('Category successfully created.')
  end

  it 'cannot create category and displays error message' do
    FactoryGirl.create(:category)
    visit '/categories'
    find('#new-category-button').click
    page.find('#newCategoryModal').visible?
    within(:css, '#newCategoryModal') do
      fill_in('Name', with: 'Test Category')
    end
    click_button('Create Category')
    expect(page).to have_content('Could not create category.')
  end

  it 'can edit a category', js: true do
    category = FactoryGirl.create(:category)
    visit '/categories'
    find('#edit-category-button').click
    page.find('#editCategoryModal').visible?
    within(:css, '#editCategoryModal') do
      fill_in('Name', with: 'Updated Category')
    end
    click_button('Done')
    expect(page).to have_content('Category successfully updated.')
    category.reload
    expect(category.name).to eq('Updated Category')
  end

  it 'can delete a category', js: true do
    FactoryGirl.create(:category)
    visit '/categories'
    expect(page).to have_selector('table tr', count: 2) # including header row
    find('#delete-category-button').click
    page.find('#deleteCategoryModal').visible?
    click_button('Delete')
    expect(page).to have_content('Category deleted.')
    expect(page).to_not have_content('Test Category')
    expect(page).to have_selector('table tr', count: 2) # including header row
  end
end
