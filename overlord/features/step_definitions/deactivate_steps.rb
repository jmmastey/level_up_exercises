Given /^I wait for (\d+) seconds?$/ do |n|
  sleep(n.to_i)
end

And /^I cannot enter "([^\"]*)" code$/ do |field|
  id = "#" + field + "-bomb"
  using_wait_time 10 do
    page.has_css?(field, visible: false)
  end
end

Then /^the number of tries left is (\d+)$/ do |tries|
  pp find('.count')
end
