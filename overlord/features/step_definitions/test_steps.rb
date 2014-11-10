ACTIVATION_CODES =
{
  'arming' => { 'correct' => '3456', 'incorrect' => '5678' },
  'disarming' => { 'correct' => '5678', 'incorrect' => '6789' }
}

def code_input_id(code_type)
  "##{code_type}CodeInput"
end

def control_panel_state_is(*states)
  states.include?(page.evaluate_script('CONTROLPANEL.state'))
end

def click_element(locator)
  find(locator).click
end

Given(/a new bomb session/) do
  true # Capybara always starts one for each test
end

Then(/see the activation code registration controls/) do
  has_css?("#activationCodes")
end

Then(/see the ((?:dis)?arming) code (\d+)/) do |code_type, code|
  activation_code = find(code_input_id(code_type)).value
  puts "\nCODE I SEE #{activation_code}\n"
  expect(activation_code).to eq(code)
end

When(/(?:view|am viewing) the bomb controls/) do
  visit('/control_panel')
end

Then(/I see a field to register an? ((?:dis)?arming) code/) do |code_type|
  has_registration_field = has_css?(code_input_id(code_type))
  expect(has_registration_field).to be_truthy
end

When(/the bomb has no activation codes registered/) do
  step "I am viewing the bomb controls"
  expect(control_panel_state_is('initial')).to be_truthy
end

When(/enter(?: an?)?(?: (?:non-)?numeric)? ((?:dis)?arming) code "(\S+)"/) do |code_type, code|
  fill_in("#{code_type}CodeInput", with: code)
end

When(/(do not )?press the "(.*)" button/) do |dont, which_button|
  click_element("##{which_button}Button") unless dont

end

Then(/see that activation codes are registered/) do
  expect(control_panel_state_is('locked', 'armed')).to be_truthy
end

Given(/the bomb has activation codes registered/) do
  step "am viewing the bomb controls"
  step "enter arming code \"#{ACTIVATION_CODES['arming']['correct']}\""
  step "enter disarming code \"#{ACTIVATION_CODES['disarming']['correct']}\""
  step "press the \"commit\" button"
  step "see that activation codes are registered"
end

arming_code_expr = /enter (?:an?|the) ((?:in)?correct) ((?:dis)?arming) code/

When(arming_code_expr) do |correct, code_type|
  step "enter #{code_type} code \"#{ACTIVATION_CODES[code_type][correct]}\""
end

Then(/see the ((?:dis)?arming) authorization controls/) do |which_button|
  has_button_control = has_css?("##{which_button}Button")
  expect(has_button_control).to be_truthy
end

Then(/see the bomb is (?:still )?disarmed/) do
  has_correct_arming_state = has_css?("#disarmingButton.disarmingButtonBright")
  expect(has_correct_arming_state).to be_truthy
end

Given(/(?<!see )the bomb is disarmed/) do
  step "the bomb has activation codes registered"
end

When(/see the bomb is (?:still )?armed/) do
  is_armed = control_panel_state_is('armed') &&
             has_css?("#armingButton.armingButtonBright")
  expect(is_armed).to be_truthy
end

Given(/(?<!see )the bomb is armed/) do
  step "the bomb has activation codes registered"
  step "enter arming code \"#{ACTIVATION_CODES['arming']['correct']}\""
  step "enter disarming code \"#{ACTIVATION_CODES['disarming']['correct']}\""
  step "press the \"arming\" button"
  step "press the \"commit\" button"
  step "see the bomb is armed"
end

When(/attempt to disarm bomb with incorrect disarming code(?: (\d+) times)?/) do |count|
  (count || "1").to_i.times do
    step "enter an incorrect disarming code"
    step "press the \"disarming\" button"
    step "press the \"commit\" button"
  end
end

When(/see the bomb explode/) do
  expect(page.title).to eq('KABOOM!')
end
