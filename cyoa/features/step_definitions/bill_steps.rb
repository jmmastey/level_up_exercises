Given(/^these bills exist:$/) do |table|
  table.hashes.each do |attributes|
    create(:bill, attributes)
  end
end

When(/^I search bills for "(.*?)"$/) do |input|
  search('BILLS', input)
end

When(/^I search and click on a result for "(.*?)"$/) do |input|
  search('BILLS', input)
  find('#results', match: :first)
  page.find('tr', text: input).click
end

Then(/^I see no results found$/) do
  expect(page).to have_content("No results found")
end

def search(filter, text)
  find('.query-filter', text: filter).click
  find("input[type='search']").set(text)
  page.execute_script("$('form#search').submit()")
end
