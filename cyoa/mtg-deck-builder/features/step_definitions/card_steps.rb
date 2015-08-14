Given(/^there are (.+) cards in the database$/) do |n|
  @cards = Array.new(Integer(n)) { create(:card) }
end

Given(/^there is a card named (.*) in the database$/) do |card_name|
  @card = create(:card, name: card_name)
end
