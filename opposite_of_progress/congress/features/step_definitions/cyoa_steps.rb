require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

Given(/^there are no "(.*?)"$/) do |object_name|
  DatabaseCleaner.start
end

Given(/^I create a bill titled "(.*?)"$/) do |title|
  Bill.create!(short_title: title)
end

Given(/^I create a legislator named "(.*?)"$/) do |name|
  Legislator.create!(last_name: name)
end

Then(/^I should see a message "(.*?)"$/) do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then(/^I should see a title for "(.*?)"$/) do |text|
  with_scope("h3") do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end
