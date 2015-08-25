When(/^I create a deck named (.*)$/) do |deck_name|
  visit('/decks/new')
  fill_in 'decks[name]', with: deck_name
  click_button 'Create New Deck'
end
