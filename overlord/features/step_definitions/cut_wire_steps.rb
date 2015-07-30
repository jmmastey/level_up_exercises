When(/^I cut the (correct|wrong) wire$/) do |wire_type|
  selector = ".wire.#{wire_type}"
  page.first(selector).click
end
