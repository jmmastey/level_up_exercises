require_relative '../../bomb'

def fill_activate_code(code)
  code = code.to_s
  fill_in('activation-code', :with => code)
end

def fill_deactivate_code(code)
  code = code.to_s
  fill_in('deactivation-code', :with => code)
end

def activate(code)
  fill_activate_code(code)
  click_button('activate')
end

def attempt_deactivate(code, attempts = 1)
  attempts = Bomb::MAX_ALLOWED_DEACTIVATION_ATTEMPTS if attempts == 'max'

  attempts.times.each do
    fill_deactivate_code(code)
    click_button('deactivate')
  end
end
