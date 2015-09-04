require 'rails_helper'

describe 'home page' do
  before(:each) do
    page.set_rack_session(user_id: nil)
  end

  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content('Welcome!')
  end

  it 'has a Google sign-in button' do
    visit '/'
    expect(page).to have_selector('#google-sign-in-button', visible: true)
  end
end
