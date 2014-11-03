ACTIVATION_CODES =
{
  'arming' => { 'correct' => '3456', 'incorrect' => '5678' },
  'disarming' => { 'correct' => '5678', 'incorrect' => '6789' }
}

def fail(message = "Test failed")
  raise message
end

def codeInputId(which_code)
  "##{which_code}CodeInput"
end

def controlpanel_state_is(*states)
  states.include?(page.evaluate_script('CONTROLPANEL.state'))
end

def click_element(locator)
  find(locator).click
end

Given(/the bomb is not started/) do
  true
end

When(/^start the bomb$/) do
  visit('/')
end

Then(/see the activation code registration controls/) do
  has_css?("#activationCodes")
end

Then(/see the ((?:dis)?arming) code (\d+)/) do |which_code, codeval|
  fail unless find(codeInputId(which_code)).value == codeval
end

When(/(?:view|am viewing) the bomb controls/) do
  visit('/control_panel')
end

Then(/I see a field to register an? ((?:dis)?arming) code/) do |which_code|
  fail unless has_css?(codeInputId(which_code))
end

When(/the bomb has no activation codes registered/) do
  step "I am viewing the bomb controls"
  fail unless controlpanel_state_is('initial')
end

When(/enter(?: an?)?(?: (?:non-)?numeric)? ((?:dis)?arming) code "(\S+)"/) do |which_code, code|
  fill_in("#{which_code}CodeInput", {with: code})
end

When(/(do not )?press the "(.*)" button/) do |dont, which_button|
  click_element("##{which_button}Button") unless dont

end

Then(/see that activation codes are registered/) do
  fail unless controlpanel_state_is('locked', 'armed')
end

Given(/the bomb has activation codes registered/) do
  step "am viewing the bomb controls"
  step "enter arming code \"#{ACTIVATION_CODES['arming']['correct']}\""
  step "enter disarming code \"#{ACTIVATION_CODES['disarming']['correct']}\""
  step "press the \"commit\" button"
  step "see that activation codes are registered"
end

When(/enter (?:an?|the) ((?:in)?correct) ((?:dis)?arming) code/) do |correct, which_code|
  step "enter #{which_code} code \"#{ACTIVATION_CODES[which_code][correct]}\""
end

Then(/see the ((?:dis)?arming) authorization controls/) do |which_button|
  fail unless has_css?("##{which_button}Button")
end

Then(/see the bomb is (?:still )?disarmed/) do
  fail unless controlpanel_state_is('locked') &&
              has_css?("#disarmingButton.disarmingButtonPushed")
end

Given(/(?<!see )the bomb is disarmed/) do
  step "the bomb has activation codes registered"
end

When(/see the bomb is (?:still )?armed/) do
  fail unless controlpanel_state_is('armed') &&
              has_css?("#armingButton.armingButtonPushed")
end

Given(/(?<!see )the bomb is armed/) do
  step "the bomb has activation codes registered"
  step "enter arming code \"3456\""
  step "enter disarming code \"5678\""
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
  fail unless page.title == 'KABOOM!'
end
