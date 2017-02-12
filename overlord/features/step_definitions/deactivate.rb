def submit_incorrect_deactivation_code
  fill_in('code', :with => '9999')
  click_button('submit')
end

When(/^I submit the correct deactivation code$/) do
  fill_in('code', :with => '0000')
  click_button('submit')
end

When(/^I submit an incorrect deactivation code ([0-9]+) times?$/) do |count|
  count.to_i.times { submit_incorrect_deactivation_code }
end
