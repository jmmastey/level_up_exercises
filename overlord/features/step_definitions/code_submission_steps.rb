Given /^I want to activate the bomb$/ do
  visit('/')
end

When /^I enter the activation code '([^"]*)'$/ do |code|
  fill_in 'code', with: code
  click_button 'submit'
end

Then /^the bomb should be active$/ do
  page.has_content?('Bomb is Active')
end

Then /^the bomb should tell me I am an idiot$/ do
  page.has_css?('dummy')
end
