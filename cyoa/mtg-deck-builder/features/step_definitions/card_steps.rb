Given(/^there are (.+) cards in the database$/) do |n|
  @cards = Array.new(Integer(n)) { create(:card) }
end

Given(/^there is a card named "(.*)" in the database$/) do |card_name|
  @card = create(:card, name: card_name)
end

Given(/^there is a card with type "(.*)" in the database$/) do |card_type|
  @card = create(:card)
  @type = create(:type, name: card_type)
  CardsType.create(card_id: @card.id, type_id: @type.id)
end

Given(/^there is a card with types "(.*)" in the database$/) do |card_types|
  @card = create(:card)
  card_types.split(',').each do |type_name|
    @type = create(:type, name: type_name)
    CardsType.create(card_id: @card.id, type_id: @type.id)
  end
end

When(/^I visit the card search page$/) do
  visit(cards_path)
end

When(/^I search for the card named "(.*)"$/) do |card_name|
  fill_in 'cardname', with: card_name
end

When(/^I search for cards with type "(.*)"$/) do |card_type|
  page.execute_script('$("#types").tagit("createTag", "#{card_type}")')
end

Then(/^I should see the card named "(.*)"$/) do |card_name|
  expect(page).to have_content(card_name)
end

Then(/^I should see at least (.*) cards with the type "(.*)"$/) do |n, card_type|
  expect(find('.cards', match: :first)).to have_content(card_type, count: n)
end
