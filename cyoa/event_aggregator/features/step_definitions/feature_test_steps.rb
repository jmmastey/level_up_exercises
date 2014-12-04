Given /^I am visiting the "(.*)" page$/ do |url_nickname|
  visit url_by_nickname(url_nickname)
end
