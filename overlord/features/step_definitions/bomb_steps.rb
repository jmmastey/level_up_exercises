Given(/^"(.*?)" says "(.*?)"$/) do |selector_id, status_text|
  selector_id.should have_content(status_text)
end

Given(/^"(.*?)" is not configured$/) do |arg1|
  Bomb.create(activation_code: "1234")
  visit "/bomb"
  %w(1 2 3 4).each do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

Given(/^"(.*?)" is configured to "(.*?)"$/) do |arg1, arg2|
  visit "/bomb"
  arg2.each_char do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

When(/^I enter right "(.*?)"$/) do |arg1|
  visit "/bomb"
  %w(1 2 3 4).each do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

Then(/^"(.*?)" should contain "(.*?)"$/) do |arg1, arg2|
  visit "/bomb"
  arg2.each_char do |num|
    find(:xpath, "//span[@class='"+num+"']").click
  end
end

Then /^(?:|I )should see "([^\"]*)"(?: with id of textarea "([^\"]*)")?$/ \
do |text, selector|
  selector.should have_content("Inactive")
end
