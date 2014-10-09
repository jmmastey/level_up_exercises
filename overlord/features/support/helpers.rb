def host_url
  @host = ENV['TEST_HOST'] ? ENV['TEST_HOST'] : "localhost:4567"
  overlord_url = @host.start_with?('http') ? @host : "http://#{@host}"
  @overlord_url = "#{overlord_url}"
end

def code_config(act_code, deact_code)
  fill_in 'activation', :with => act_code
  fill_in 'deactivation', :with => deact_code
  click_button 'submit my codes!'
end

def default_config
  visit host_url
  click_button 'submit my codes!'
end

def activation_page
  visit 'http://localhost:4567'
end

def activate_bomb(activation_code)
  fill_in 'activation', :with => activation_code
  click_button 'Activate'
end

def deactivate_bomb(deactivation_code)
  fill_in 'deactivation', :with => deactivation_code
end