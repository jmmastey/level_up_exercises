Then(/^I should be on the (.*?) page$/) do |arg1|
  current_path = URI.parse(current_url).path
  page = (arg1 == "home") ? "/" : "/#{arg1}"
  expect(current_path).to eql(page)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
