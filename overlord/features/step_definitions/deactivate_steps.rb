Given(/^I wait for (\d+) seconds?$/) do |n|
  sleep(n.to_i)
end

And(/^I cannot enter "([^\"]*)" code$/) do |field|
  page.has_css?(field, visible: false)
end
