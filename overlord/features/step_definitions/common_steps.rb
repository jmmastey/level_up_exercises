Then /^I should see (.*) button(?: (.*))?$/ do |button, status|
  if status == 'disabled'
    expect(find_button(button, disabled:true)[:disabled]).to be_truthy
  else
    expect(find_button(button)).to be_truthy
  end
end

Then(/^I should not see "(.*?)" field$/) do |button|
  expect(page).not_to have_button(button)
end

Then(/^I should not see "(.*?)" button$/) do |field|
  expect(page).not_to have_field(field)
end

Then(/^I should see "(.*?)" link$/) do |link|
  expect(page).to have_link(link)
end
