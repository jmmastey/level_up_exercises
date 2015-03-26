Given(/^there is currently no bomb$/) do
  visit('/')
end

And(/^I click on the initialize button$/) do
  click_button('initialize')
end
