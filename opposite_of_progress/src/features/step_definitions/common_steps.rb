### Givens
Given /^I am on\s+(.+)\s+page/ do |page|
  visit(path(page))
end

### Whens
When /^I click (.+) link$/ do |link|
  within('.content-container') do
    click_link(link)
  end
end

When /^I click (.+) link in topbar$/ do |link|
  within('.top-bar') do
    click_link(link)
  end
end

### Thens
Then /^I see (.+) link$/ do |link|
  within('.content-container') do
    expect(page).to have_link(link)
  end
end

Then /^I see (.+) link in topbar$/ do |link|
  within('.top-bar') do
    expect(page).to have_link(link)
  end
end

Then /^I should be on\s+(.+)\s+page/ do |page|
  assert_path(path(page))
end

When /^I click on pagination next$/ do
  within('.pagination') do
    click_link('Next')
  end
end
