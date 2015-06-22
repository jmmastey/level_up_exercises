require 'pry'

module SessionStepsHarness
  @alert_message = ''

  def activate_bomb
    code_field.set default_activation_code
    submit_security_form
  end

  def code_field
    find_field('code')
  end

  def create_bomb
    first('.create-bomb').click
  end

  def deactivate_bomb
    code_field.set default_deactivation_code
    submit_security_form
  end

  def default_activation_code
    '1234'
  end

  def default_deactivation_code
    '0000'
  end

  def explode_bomb
    activate_bomb
    3.times do
      submit_random_code([default_activation_code])
    end
  end

  def submit_random_code(blacklist = [])
    code = generate_random_code(blacklist)
    code_field.set(code)
    submit_security_form
  end

  def generate_random_code(blacklist = [])
    loop do
      code = ''
      4.times { code += rand(9).to_s }
      return code unless blacklist.include?(code)
    end
  end

  def submit_security_form
    find('form[name="security"] input[type="submit"]').click
    capture_error_message
  end

  def capture_error_message
    alert = page.driver.browser.switch_to.alert
    @alert_message = alert.text
    alert.accept
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    return
  end
end

World(SessionStepsHarness)

Given(/^I am viewing an (.*) bomb$/) do |bomb_status|
  visit '/'
  create_bomb
  case bomb_status
  when 'active'
    activate_bomb
  when 'exploded'
    explode_bomb
  end
end

Given(/^there is no bomb present$/) do
  visit '/'
end

When(/^I submit any code that is not the activation code$/) do
  submit_random_code([default_activation_code])
end

When(/^I submit any code that is not the deactivation code$/) do
  submit_random_code([default_deactivation_code])
end

When(/^I submit any code that is not the activation code or deactivation code$/) do
  submit_random_code([default_activation_code, default_deactivation_code])
end

When(/^I submit any code that is not the deactivation code (\d+) times$/) do |arg1|
  3.times { submit_random_code([default_deactivation_code]) }
end

When(/^I submit the deactivation code$/) do
  deactivate_bomb
end

When(/^I submit the activation code$/) do
  activate_bomb
end

Then(/^I get an alert that says "([^"]*)"$/) do |alert|
  fail unless @alert_message.downcase.include? alert.downcase
end

Then(/^the bomb is (.*)$/) do |bomb_status|
  fail unless bomb_status == find('span.bomb-status').text
end

Then(/^the security code form should be gone$/) do
  fail unless first('form').nil?
end

Then(/^I should see a link to create a new bomb$/) do
  fail if first('.create-bomb').nil?
end
