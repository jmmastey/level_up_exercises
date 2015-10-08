Given /^I want to activate the bomb$/ do
	visit('/')
end

When /^I enter the activation code '([^"]*)'$/ do |code|
  		fill_in 'code', :with => '1234'
  		click_button 'submit'
end

Then /^the bomb should be active$/ do
	page.has_content?('Bomb is Active')
end
