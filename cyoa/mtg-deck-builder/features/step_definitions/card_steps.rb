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

Given(/^there is a card with "(.*)"$/) do |text|
  @card = create(:card, text: text)
end

Given(/^there is a card with colors "(.*)"$/) do |colors|
  @card = create(:card, colors: colors.split(','))
end

When(/^I visit the card search page$/) do
  visit(cards_path)
end

When(/^I search for the card named "(.*)"$/) do |card_name|
  fill_in 'cardname', with: card_name
end

When(/^I search for cards with type "(.*)"$/) do |card_type|
  find('#types')
  page.execute_script("$('#types').tagit('createTag', '#{card_type}')")
end

When(/^I search for cards with "(.*)"$/) do |text|
  find('#cardtext')
  page.execute_script("$('#cardtext').tagit('createTag', '#{text}')")
end

When(/^I search for cards with colors "(.*)"$/) do |colors|
  colors.split(',').each { |color| find("label[for='#{color}']", match: :first).click }
end

Then(/^I should see the card named "(.*)"$/) do |card_name|
  expect(page).to have_content(card_name)
end

Then(/^I should see at least (.*) cards with the type "(.*)"$/) do |n, card_type|
  expect(find('.cards', match: :first)).to have_content(card_type, count: n)
end

Then(/^I should see at least (.*) cards with "(.*)"$/) do |n, text|
  card_id = find('tr.card', match: :first)['data-card-id']
  expect(Card.find(card_id).text.include?(text)).to eq(true)
end

Then(/^I should see at least 1 cards with colors "(.*)"$/) do |colors|
  card_id = find('tr.card', match: :first)['data-card-id']
  colors.split(',').each do |color|
    expect(Card.find(card_id).colors.include?(color)).to eq(true)
  end
end
