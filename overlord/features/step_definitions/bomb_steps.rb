Given /^I have a new bomb$/ do
  page.driver.put("/bomb")
end

Given /^I booted the bomb$/ do
  page.driver.post("/boot")
end

Given /^I submit code "([^"]*)"$/ do |code|
  page.driver.post("/submit_code", code: code)
end

Given /^set (.*) key to "([^"]*)"$/ do |dest, key|
  path = "/set_" + dest + "_key"
  page.driver.post(path, key: key)
end

Then /^I should see an unbooted bomb$/ do
  visit "/"
  body.should have_content("off")
end

When /^I boot the bomb$/ do
  page.driver.post("/boot")
end

Then /^the bomb is (.+)$/ do |status|
  visit "/"
  body.should eq(status)
end

Then /^the time is "([^"]*)"$/ do |time|
  visit "/timer"
  body.should have_content(time)
end

Then /^submit code "([^"]*)" (.*)$/ do |code, result|
  page.driver.post("/submit_code", code: code)
  case result
  when "succeeds"
    body.should have_content(code)
  when "fails (not booted)"
    body.should eq("Code Entry Requires a Booted Bomb")
  when "fails (invalid)"
    body.should have_content("Incorrect Code")
  else
    raise "Invalid Step Definition Choice"
  end
end

Then /^set (.*) key to "([^"]*)" (.*)$/ do |dest, key, result|
  path = "/set_" + dest + "_key"
  page.driver.post(path, key: key)
  case result
  when "succeeds"
    body.should eq(key)
  when "fails"
    body.should have_content("Cannot Change Once Bomb is Booted")
  else
    raise "Invalid Step Definition Choice"
  end
end

