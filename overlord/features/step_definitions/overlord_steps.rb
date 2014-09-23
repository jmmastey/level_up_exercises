Given /I visit the main page/ do
  visit '/overlords'
end

Given /I create a bomb from the main page/ do
  visit '/overlords'
  click_button 'Create!'
end

When /I select code (\d+)/ do |code_value|
  set_keypad_code(code_value)
end

When /I press activate/ do
  click_activate_button()
end

When /I press deactivate/ do
  click_deactivate_button()
end

When /I click on snip/ do
  click_snip_wires()
end

When /I detonate the bomb/ do
  detonate_bomb()
end



Then /I should see the Create Bomb page/ do
  expect(body.match('Overlords')).to be_truthy
end

Then /I should see the bomb status page/ do
  expect(page.title).to eq("Bomb Status")
end


# Integrity
Then /the bomb should be intact/ do
  expect(value_of_field("integrity")).to eq("Intact")
end

Then /the bomb should be exploded/ do
  expect(value_of_field("integrity")).to eq("Blown to shreds")
end

Then /the bomb should be snipped/ do
  expect(value_of_field("integrity")).to eq("Wires are cut")
end


# Activation
Then /the bomb should be activated/ do
  expect(value_of_field("activation")).to eq("Active")
end

Then /the bomb should not be activated/ do
  expect(value_of_field("activation")).to eq("Inactive")
end

Then /the bomb should have defunct activation/ do
  expect(value_of_field("activation")).to eq("NA")
end


Then /the deactivation attempts should be (\d+)/ do |attempts|
  expect(value_of_field("deact_attempts")).to eq(attempts)
end

Then /the bomb message should be \"(.*?)\"/ do |message|
  expect(value_of_field("bomb_msg")).to eq(message)
end




def value_of_field(label)
  field = page.find("meta[name=#{label}]", :visible => false)
  field[:content]
end

def click_activate_button
  set_keypad_action("activate")
  click_submit_action()
end

def click_deactivate_button
  set_keypad_action("deactivate")
  click_submit_action()
end

def click_submit_action
  button = page.find("button[@id='keypad_submit']", :visible => false)
  button.click
end

def click_snip_wires
  set_keypad_action("snip")
  click_submit_action()
end

def set_keypad_code(code)
  find(:xpath, "//input[@id='keypad_code']").set "#{code}"
end

def set_keypad_action(value)
  find(:xpath, "//input[@id='keypad_action']").set value
end

def detonate_bomb
  set_keypad_action("detonate")
  click_submit_action()
end
