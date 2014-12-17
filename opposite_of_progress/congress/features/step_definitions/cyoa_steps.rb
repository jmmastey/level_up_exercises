Given(/^there are no bills$/) do
  
end

Then(/^I should not see any bills$/) do

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