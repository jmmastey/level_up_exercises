Given(/^the following legislators exist:$/) do |table|
  table.hashes.each do |hash|
    create(:legislator, hash)
  end
end

Given(/^the following congressional districts exist:$/) do |table|
  table.hashes.each do |hash|
    create(:congressional_district, hash)
  end
end

Given(/^I visit "(.*?)"$/) do |url|
  visit(url)
end

When(/^I search legislators for "(.*?)"$/) do |input|
  search('LEGISLATORS', input)
end

When(/^I click on "(.*?)"$/) do |text|
  page.find('tr', text: text).click
end

Then(/^I see (\d+) legislators$/) do |result_count|
  find('#results', match: :first)
  expect(all('#results tbody tr').count).to eq(result_count.to_i)
end

Then(/^I see the legislator page for "(.*?)"$/) do |name|
  expect(page).to have_content(name)
end
