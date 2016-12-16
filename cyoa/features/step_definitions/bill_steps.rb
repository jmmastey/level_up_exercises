Given(/^these bills exist:$/) do |table|
  table.hashes.each do |attributes|
    create(:bill, attributes)
  end
end

When(/^I search bills for "(.*?)"$/) do |input|
  find('.query-filter', text: 'BILLS').click
  fill_in('query', with: input)
  page.execute_script("$('form#search').submit()")
end

Then(/^I see no results found$/) do
  expect(page).to have_content("No results found")
end
