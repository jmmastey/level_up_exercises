

# -------------------------------------
# bomb activation
# -------------------------------------

Given(/^I activate the bomb$/) do
  fill_in('code', :with => '1234')
  click_button('submit')
end

Given(/^I activate the bomb with the new activation code$/) do
  fill_in('code', :with => '4567')
  click_button('submit')
end

Given(/^I supply an invalid activation code$/) do
  fill_in('code', :with => '9999')
  click_button('submit')
end


# -------------------------------------
# bomb deactivation
# -------------------------------------

Given(/^I deactivate the bomb$/) do
  fill_in('code', :with => '0000')
  click_button('submit')
end

Given(/^I deactivate the bomb with the new deactivation code$/) do
  fill_in('code', :with => '1000')
  click_button('submit')
end

Given(/^I supply an invalid deactivation code$/) do
  fill_in('code', :with => '9999')
  click_button('submit')
end

Given(/^I supply an invalid deactivation code three times$/) do
  fill_in('code', :with => '9999')
  click_button('submit')

  fill_in('code', :with => '9999')
  click_button('submit')

  fill_in('code', :with => '9999')
  click_button('submit')
end

# -------------------------------------
# update activation code
# -------------------------------------

Given(/^I update the bomb's activation code$/) do
  fill_in('activation_code', :with => '4567')
  click_button('update_activation_code')
end

Given(/^I update the bomb's activation code with an invalid value$/) do
  fill_in('activation_code', :with => 'abcd')
  click_button('update_activation_code')
end

# -------------------------------------
# update deactivation code
# -------------------------------------

Given(/^I update the bomb's deactivation code$/) do
  fill_in('deactivation_code', :with => '1000')
  click_button('update_deactivation_code')
end

Given(/^I update the bomb's deactivation code with an invalid value$/) do
  fill_in('deactivation_code', :with => 'abcd')
  click_button('update_deactivation_code')
end
