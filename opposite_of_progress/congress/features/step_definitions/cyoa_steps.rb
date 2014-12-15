Then(/^I should see a title for "(.*?)"$/) do |arg1|
  with_scope("h3") do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end