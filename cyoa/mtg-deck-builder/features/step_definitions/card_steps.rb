Given(/^there are (.+) cards in the database$/) do |n|
  @cards = Array.new(Integer(n)) { create(:card) }
end

Given(/^there is a card named (.*) in the database$/) do |card_name|
  @card = create(:card, name: card_name)
end

Given(/^there is a card with type (.*) in the database$/) do |card_type|
  pending # Need to figure out how I'll be implementing card types...
  @card = create(:card, types: [card_type])
end

When(/^I visit the card search page$/) do
  visit(cards_path)
end

When(/^I search for the card named (.*)$/) do |card_name|
  fill_in 'cardname', with: card_name
end

When(/^I search for cards with type (.*)$/) do |card_type|
  fill_in 'cardtypes', with: card_type
end

Then(/^I should see the card named (.*)$/) do |card_name|
  expect(page).to have_content(card_name)
end

Then(/^I should see at least (.*) cards with the type (.*)$/) do |n, card_type|
  expect(find('.cards', match: :first)).to have_content(card_type, count: n)
end
