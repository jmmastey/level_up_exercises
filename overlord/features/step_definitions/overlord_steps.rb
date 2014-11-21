Given(/^I have activated the bomb$/) do
  body_element = find('body')
  body_element.native.send_keys("activate 1234", :Enter)

  wait_for_ajax do
    console_element = find('.console .output')
    console_element.should have_content("Bomb is active")
  end
end

Given(/^I have begun the countdown sequence$/) do
  body_element = find('body')
  console_element = find('.console .output')
  body_element.native.send_keys("activate 1234", :Enter)

  wait_for_ajax do
    console_element.should have_content("Bomb is active")
  end

  body_element.native.send_keys("detonate 1", :Enter)
  sleep 1
  wait_for_ajax do
    console_element.should have_content("Bomb detonated")
  end
end

Given(/^The bomb is deactivated$/) do
  wait_for_ajax do
    console_element = find('.console .output')
    console_element.should have_content("inactive")
  end
end

When(/^I wait for (\d+) seconds$/) do |seconds|
  sleep seconds.to_i
end

When(/^I wait for ajax request to finish$/) do
  start_time = Time.now
  until page.evaluate_script('$.active==0') or start_time < Time.now do
    sleep 1
  end
end

When(/^I type "(.*?)"$/) do |string|
  body_element = find('body')
  body_element.native.send_key(string)
end

When(/^I enter the query$/) do
  body_element = find('body')
  body_element.native.send_key(:Enter)
  wait_for_ajax do
    true
  end
end

Then(/^The bomb should be detonated$/) do
  console_element = find('.console')
  console_element.should have_content("Bomb detonated")
end

Then(/^The bomb should be deactivated$/) do
  console_element = find('.console')
  console_element.should have_content("Bomb is inactive")
end

Then(/^The bomb should be activated$/) do
  console_element = find('.console')
  console_element.should have_content("Bomb is active")
end

Then(/^The countdown sequence should be stopped$/) do
  console_element = find('.console')
  console_element.should have_content("Detonation sequence cancelled")
end

def wait_for_ajax
  page.evaluate_script('$.active==0')
  yield
end
