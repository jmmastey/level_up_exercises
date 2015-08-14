def edit_deck(deck)
  visit(edit_deck_path(deck))
end

def add_card(card_id)
  selector = "tr[data-card-id=\"#{card_id}\"] a.add"
  find(selector, match: :first).click
end

def remove_card(card_id)
  selector = "tr[data-card-id=\"#{card_id}\"] a.remove"
  find(selector, match: :first).click
end

def create_deck
  @deck = create(:deck, user: @user)
end

When(/^I create a deck named (.*)$/) do |deck_name|
  fill_in 'deck[name]', with: deck_name
  click_button 'Create New Deck'
end

When(/^I visit the create deck page$/) do
  visit("/decks/new")
end

Then(/^I expect to have (.*) deck named (.*)$/) do |n, deck_name|
  expect(@user.decks.count).to eq(1)
  expect(@user.decks.first.name).to eq(deck_name)
end

When(/^I create a deck$/) do
  create_deck
end

When(/^I visit the edit deck page$/) do
  edit_deck(@deck)
end

When(/^I add a card with id (.*)$/) do |card_id|
  add_card(card_id)
end

When(/^I remove a card with id (.*)$/) do |card_id|
  remove_card(card_id)
end

Then(/^I expect to have (.*) cards in my deck$/) do |n|
  expect(page).to have_selector(".card-in-deck", count: n)
end

Then(/^I expect to have a card with id (.*) in my deck$/) do |card_id|
  expect(page).to have_selector(".card-in-deck[data-card-id=\"#{card_id}\"]")
end
