Then(/^I should be on the (.*?) page$/) do |page_name|
  current_path = URI.parse(current_url).path
  page = (page_name == "home") ? "/" : "/#{page_name}"
  expect(current_path).to eql(page)
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
