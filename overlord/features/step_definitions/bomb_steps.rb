Given(/^the villian is on the homepage$/) do
  visit("/")
end

When(/^the villian enters the bomb activation code "([^"]*)"$/) do |code|
  fill_in_active_code(code)
end

When(/^the villian enters the bomb deactivation code "([^"]*)"$/) do |code|
  fill_in_deactive_code(code)
end

When(/^the villian clicks "([^"]*)"$/) do |button_text|
  click_button(button_text)
end

When(/^the bomb has been deployed$/) do
  click_button("DEPLOY")
  using_wait_time 10 do
    expect_bomb_status("ready for activation")
  end
end

When(/^the bomb has been activated$/) do
  fill_in_active_code("1233")
  click_button("ACTIVATE")
  using_wait_time 10 do
    expect_bomb_status("activated")
  end
end

When(/^the hero enters an incorrect deactivation code three times$/) do
  fill_in_deactive_code("1111")
  click_button("DEACTIVATE")
  using_wait_time 10 do
    expect(page).to have_content("Attempts Remaining: 2")
  end

  fill_in_deactive_code("1112")
  click_button("DEACTIVATE")
  using_wait_time 10 do
    expect(page).to have_content("Attempts Remaining: 1")
  end

  fill_in_deactive_code("1113")
  click_button("DEACTIVATE")
end

Then(/^the bomb should explode$/) do
  expect(page).to have_content("Bomb Detonated")
end

Then(/^the villian expects the bomb status to be "([^"]*)"$/) do |status|
  using_wait_time 10 do
    expect_bomb_status(status)
  end
end

def fill_in_active_code(code)
  fill_in("activeCode", with: code)
end

def fill_in_deactive_code(code)
  fill_in("deactiveCode", with: code)
end

def expect_bomb_status(status)
  expect(find("#_bombStatus").text).to eql(status)
end
