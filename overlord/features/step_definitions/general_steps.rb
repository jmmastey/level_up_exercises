Then(/^I should see "(.*?)"$/) do |arg1|
  # I want this to be flashed only the first
  # time a bomb is created...How to test?
  expect(page).to have_content(arg1)
end

Given(/^a bomb has been created and activated$/) do
  visit('/')
  fill_in("create_activation_code", with: 1234)
  fill_in("create_deactivation_code", with: 0000)
  click_button('Create!')
  fill_in "activation_code", :with => 1234
  click_button('Activate!')
  expect(current_path).to eq("/bomb/active")
end

When(/^I wait (\d+) seconds to do something$/) do |arg1|
  sleep(arg1.to_i)
  click_button('Deactivate!')
end

Then(/^the bomb should have exploded$/) do
    expect(current_path).to eq("/exploded")
    expect(page).to have_content("Everyone's dead")
end