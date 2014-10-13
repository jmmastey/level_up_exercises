def host_url
  @host = ENV['TEST_HOST'] ? ENV['TEST_HOST'] : "localhost:4567"
  overlord_url = @host.start_with?('http') ? @host : "http://#{@host}"
  @overlord_url = "#{overlord_url}"
end

def configure_bomb(act_code, deact_code)
  fill_in 'activation_code', :with => act_code
  fill_in 'deactivation_code', :with => deact_code
  click_button 'Configure'
end

def activate_bomb(act_code)
  fill_in 'activation_code', :with => act_code
  click_button 'Activate!'
end

def activation_page
  visit host_url
end

def deactivate_bomb(deactivation_code)
  fill_in 'deactivation_code', :with => deactivation_code
  click_button 'Deactivate'
end