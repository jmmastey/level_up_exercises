Given /^I have a new bomb$/ do
  page.driver.post("/bomb")
end

Then /^I should see an unbooted bomb$/ do
  visit "/"
  body.should have_content("off")
end

When /^I boot the bomb$/ do
  page.driver.post("/boot")
end

Then /^The bomb is (.+)$/ do |status|
  visit "/"
  body.should have_content(status)
end
