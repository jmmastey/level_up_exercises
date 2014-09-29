def code_config(act_code, deact_code)
  visit 'http://localhost:4567'
  fill_in 'activation', :with => act_code
  fill_in 'deactivation', :with => deact_code
  click_button 'submit my codes!'
end
def default_config
  visit 'http://localhost:4567'
  click_button 'submit my codes!'
end
