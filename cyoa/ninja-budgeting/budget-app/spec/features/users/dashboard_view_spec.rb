require 'rails_helper'

describe 'dashboard page' do
  before(:each) do
    user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: user.id)
  end

  it 'welcomes the user by name' do
    visit '/dashboard'
    expect(page).to have_content('Welcome, Chris!')
  end

  it 'has no sign in button' do
    visit '/dashboard'
    expect(page).to have_no_selector('#google-sign-in-button')
  end
end
