Given /^I am on the events page$/ do
  visit('/')

end
When /^I click page "(.+)"$/ do |page_num|
  find("##{page_num}").trigger('click')
end
When /^I select "(.+)"$/ do |run_type|
  select run_type, :from => "running_type"
end
When /^I try to filter events with "(.*?)","(.*?)" and "(.*?)"$/ do |type, start_date, end_date|
  select type, :from => "running_type"
  execute_script("$('#start_date').val('#{start_date}')")
  execute_script("$('#end_date').val('#{end_date}')")
  find_button('Submit').trigger('click')
end
When /^I change "(.+)" and "(.+)"$/ do |start_date, end_date|
  fill_in("#start-date", with: start_date)
  fill_in("#end-date", with: end_date)
end

Then /^I should page "(.*?)" is marked$/ do |page_num|
  page_num = 'page_2' if page_num == 'next'
  page_num = 'page_1' if page_num == 'previous'
  a_tag = find("##{page_num}").find('a')
  expect(a_tag[:class]).to eq('active_page')
end
Then /^I should see the reponse successful$/ do
  expect(page.status_code).to eq(200)
end