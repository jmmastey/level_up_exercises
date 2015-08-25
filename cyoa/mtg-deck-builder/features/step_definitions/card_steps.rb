def check_colors_checkboxes(colors)
  colors.split(',').each { |color| find("label[for='#{color}']", match: :first).click }
end

def search_results
  Card.where(id: all('tr.card').map { |elem| elem['data-card-id'] })
end

Given(/^there are (.+) cards in the database$/) do |n|
  @cards = Array.new(Integer(n)) { create(:card) }
end

Given(/^there is a card named "(.*)" in the database$/) do |card_name|
  @card = create(:card, name: card_name)
end

Given(/^there is a card with hybrid mana$/) do
  @card = create(:card, cost: "{U/W}")
end

Given(/^there is a card with pherexian mana$/) do
  @card = create(:card, cost: "{P/W}")
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
  find("#toggle-advanced-search .btn", match: :first).click
end

When(/^I hover over a card's tooltip icon$/) do
  pending # TODO: Fix card tooltip test.
  execute_script('$($(".show-card-tooltip")[0]).mouseover()')
  @card_id = evaluate_script("$($('.card')[0]).data('card-id')")
end

When(/^I search for the card named "(.*)"$/) do |card_name|
  fill_in 'cardname', with: card_name
end

When(/^I search for cards with type "(.*)"$/) do |card_type|
  find('#types')
  execute_script("$('#types').tagit('createTag', '#{card_type}')")
end

When(/^I search for cards with "(.*)"$/) do |text|
  find('#cardtext')
  execute_script("$('#cardtext').tagit('createTag', '#{text}')")
end

When(/^I search for cards with colors "(.*)"$/) do |colors|
  check_colors_checkboxes(colors)
end

When(/^I search for cards with only colors "(.*)"$/) do |colors|
  check_colors_checkboxes(colors)
  check "exclude"
end

When(/^I search for multicolor cards$/) do
  check "multicolor"
end

When(/^I search for hybrid mana cards$/) do
  check "hybrid"
end

When(/^I search for pherexian mana cards$/) do
  check "pherexian"
end

# TODO: Fix cmc tests.
When(/^I search for cards with cmc greater than or equal to (.*)$/) do |cmc|
  fill_in "minmana", with: cmc
  find("#minmana", match: :first).native.send_keys(:return)
end

When(/^I search for cards with cmc less than or equal to (.*)$/) do |cmc|
  fill_in "maxmana", with: cmc
  find("#maxmana", match: :first).native.send_keys(:return)
end

When(/^I search for cards with cmc equal to (.*)$/) do |cmc|
  fill_in "exactmana", with: cmc
  find("#exactmana", match: :first).native.send_keys(:return)
end

Then(/^I will see the tooltip for that card$/) do
  pending # TODO: Fix card tooltip test.
  expect(page).to have_selector(".card-tooltip[data-card-id='#{@card_id}']")
end

Then(/^I will see the card named "(.*)"$/) do |card_name|
  expect(page).to have_content(card_name)
end

Then(/^I will see cards with the type "(.*)"$/) do |card_type|
  search_results.each do |card|
    expect(card.types.pluck(:name)).to include(card_type)
  end
end

Then(/^I will see cards with "(.*)"$/) do |text|
  search_results.each do |card|
    expect(card.text).to include(text)
  end
end

Then(/^I will see cards with colors "(.*)"$/) do |colors|
  search_results.each do |card|
    colors.split(',').each { |color| expect(card.colors).to include(color) }
  end
end

Then(/^I will not see cards with colors "(.*)"$/) do |colors|
  search_results.each do |card|
    colors.split(',').each { |color| expect(card.colors).to_not include(color) }
  end
end

Then(/^I will only see cards with more than one color$/) do
  search_results.each do |card|
    expect(card.colors.count).to be > 1
  end
end

Then(/^I will only see cards with hybrid mana$/) do
  search_results.each do |card|
    expect(card.cost).to include('/')
  end
end

Then(/^I will only see cards with pherexian mana$/) do
  search_results.each do |card|
    expect(card.cost).to include('P')
  end
end

Then(/^I will only see cards with cmc greater than or equal to (.*)$/) do |cmc|
  search_results.each do |card|
    expect(card.cmc).to be >= cmc
  end
end

Then(/^I will only see cards with cmc less than or equal to (.*)$/) do |cmc|
  search_results.each do |card|
    expect(card.cmc).to be <= cmc
  end
end

Then(/^I will only see cards with cmc equal to (.*)$/) do |cmc|
  search_results.each do |card|
    expect(card.cmc).to eq(cmc)
  end
end
