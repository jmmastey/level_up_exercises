Given(/^there are (.+) cards in the database$/) do |n|
  @cards = Array.new(Integer(n)) { create(:card) }
end

Given(/^there is a card named (.*) in the database$/) do |card_name|
  @card = create(:card, name: card_name)
end

When(/^I visit the card search page$/) do
  visit(cards_path)
end

When(/^I search for the card named (.*)$/) do |card_name|
  fill_in 'cardname', with: card_name
end

Then(/^I should see the card named (.*)$/) do |card_name|
  expect(page).to have_content(card_name)
end
