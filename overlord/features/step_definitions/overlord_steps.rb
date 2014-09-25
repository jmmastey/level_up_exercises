Given /I visit the main page/ do
  visit '/overlords'
end

Given /I create a bomb from the main page/ do
  visit '/overlords'
  click_button 'Create!'
end


When /I click on snip (\d+) time/ do |snips|
  snips.to_i.times { click_snip_wires }
end

When /I detonate the bomb/ do
  detonate_bomb
end

When /I activate it$/ do
  activate_bomb
end

When /I deactivate it$/ do
  deactivate_bomb
end

When /I activate it and unsuccessfully deactivate it (\d+) time/ do |attempts|
  activate_bomb
  attempts.to_i.times { deactivate_bomb('1111') }
end


Then /I should see the Create Bomb page/ do
  expect(body).to match('Overlords')
end

Then /I should see the bomb status page/ do
  expect(page.title).to eq("Bomb Status")
end


# Integrity
Then /the bomb should be intact/ do
  expect(integrity).to eq("Intact")
end

Then /the bomb should be exploded/ do
  expect(integrity).to eq("Blown to shreds")
end

Then /the bomb should be snipped/ do
  expect(integrity).to eq("Wires are cut")
end


# Activation
Then /the bomb should be activated/ do
  expect(activation).to eq("Active")
end

Then /the bomb should not be activated/ do
  expect(activation).to eq("Inactive")
end

Then /the bomb should have defunct activation/ do
  expect(activation).to eq("NA")
end


Then /the deactivation attempts should be (\d+)/ do |attempts|
  expect(deact_attempts).to eq(attempts)
end

Then /the bomb message should be \"(.*?)\"/ do |message|
  expect(bomb_message).to eq(message)
end



def activation
  value_of_field("activation")
end

def deactivation
  value_of_field("deactivation")
end

def integrity
  value_of_field("integrity")
end

def deact_attempts
  value_of_field("deact_attempts")
end

def bomb_message
  value_of_field("bomb_msg")
end


def value_of_field(label)
  field = page.find("meta[name=#{label}]", :visible => false)
  field[:content]
end

def activate_bomb(code = '1234')
  set_keypad_code(code)
  click_activate_button
end

def deactivate_bomb(code = '0000')
  set_keypad_code(code)
  click_deactivate_button
end

def click_activate_button
  page.execute_script("click_activate()")
end

def click_deactivate_button
  page.execute_script("click_deactivate()")
end

def click_snip_wires
  page.execute_script("click_snip()")
end

def set_keypad_code(code)
  page.execute_script("set_keypad_code(\"#{code}\")")
end

def detonate_bomb
  page.execute_script("detonate_bomb()")
end
