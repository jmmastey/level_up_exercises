require_relative '../../bomb'

def fill_activate_code(code)
  code = code.to_s unless code.is_a? String
  fill_in('activation-code', :with => code)
end

def fill_deactivate_code(code)
  code = code.to_s unless code.is_a? String
  fill_in('deactivation-code', :with => code)
end

def activate(code)
  fill_activate_code(code)
  click_button('activate')
end

def attempt_deactivate(code, attemps = 1)
  attemps = Bomb::MAX_ALLOWED_DEACTIVATION_ATTEMPS if attemps == 'max'

  attemps.times.each do
    fill_deactivate_code(code)
    click_button('deactivate')
  end
end
