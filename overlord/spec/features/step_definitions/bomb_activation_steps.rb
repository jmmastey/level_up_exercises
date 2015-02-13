When(/^hovering on the Overlord image$/) do
  page.find('#overlord').trigger(:mouseover)
end

When(/^clicking the image$/) do
  page.find('#overlord').trigger(:click)
end

When(/^I will enter my boot code:$/) do |table|
  # table is a Cucumber::Ast::Table
  code = table.rows_hash
  fill_in "boot_code", :with => code[:code]
end

