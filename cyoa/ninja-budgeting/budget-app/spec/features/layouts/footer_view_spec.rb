require 'rails_helper'

describe 'footer' do
  it 'has creator info' do
    visit '/'
    expect(page).to have_content('Ninja Budgeting by Chris O\'Hara')
  end
end
