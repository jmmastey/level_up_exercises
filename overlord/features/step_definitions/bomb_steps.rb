require 'pry'

module SessionStepsHarness
  def activate_bomb
    code_field.set default_activation_code
    submit_security_form
  end

  def code_field
    find_field('code')
  end

  def create_bomb
    page.first('.create-bomb').click
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
  end
end
World(SessionStepsHarness)

Given(/^I am viewing an (.*) bomb$/) do |bomb_status|
  visit '/'
  create_bomb
  case bomb_status
  when 'active'
    activate_bomb
  when 'inactive'
    deactivate_bomb
  when 'exploded'
    explode_bomb
  end
end

When(/^I enter any code that is not the (.*) code (\d+) times?$/) do |code_type, attempts|
  attempts.to_i.times do
    case code_type
    when 'activation'
      submit_random_code([default_activation_code])
    when 'deactivation'
      submit_random_code([default_deactivation_code])
    end
  end
end

When(/^I enter the (.*) code$/) do |code_type|
  case code_type
  when 'activation'
    code_field.set default_activation_code
  when 'deactivation'
    code_field.set default_deactivation_code
  end
  submit_security_form
end

Then(/^the bomb is (.*)$/) do |bomb_status|
  fail unless bomb_status == find('span.bomb-status').text
end

Then(/^the security code form should be gone$/) do
  fail unless first('form').nil?
end

Then(/^nothing happens$/) do
  # do nothing
end
