

# -------------------------------------
# generic steps from web_steps
# -------------------------------------

def with_scope(locator)
  locator ? within(locator) { yield } : yield
end

# (I) go to $page_name
When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

# -------------------------------------
# bomb activation
# -------------------------------------

Given(/^I activate the bomb$/) do
  submit_form('code', '1234', 'submit')
end

Given(/^I activate the bomb with the new activation code$/) do
  submit_form('code', '4567', 'submit')
end

Given(/^I supply an invalid activation code$/) do
  submit_form('code', '9999', 'submit')
end


# -------------------------------------
# bomb deactivation
# -------------------------------------

Given(/^I deactivate the bomb$/) do
  submit_form('code', '0000', 'submit')
end

Given(/^I deactivate the bomb with the new deactivation code$/) do
  submit_form('code', '1000', 'submit')
end

Given(/^I supply an invalid deactivation code$/) do
  submit_form('code', '9999', 'submit')
end

Given(/^I supply an invalid deactivation code three times$/) do
  3.times do
    submit_form('code', '9999', 'submit')
  end
end

# -------------------------------------
# update activation code
# -------------------------------------

Given(/^I update the bomb's activation code$/) do
  submit_form('activation_code', '4567', 'update_activation_code')
end

Given(/^I update the bomb's activation code with an invalid value$/) do
  submit_form('activation_code', 'abcd', 'update_activation_code')
end

# -------------------------------------
# update deactivation code
# -------------------------------------

Given(/^I update the bomb's deactivation code$/) do
  submit_form('deactivation_code', '1000', 'update_deactivation_code')
end

Given(/^I update the bomb's deactivation code with an invalid value$/) do
  submit_form('deactivation_code', 'abcd', 'update_deactivation_code')
end


# -------------------------------------
# helpers
# -------------------------------------

def submit_form(name, value, button)
  fill_in(name, :with => value)
  click_button(button)
end
