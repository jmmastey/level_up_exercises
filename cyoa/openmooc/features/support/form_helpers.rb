def submit_form(form_name, inputs = {})
  enter_form(inputs)
  click_button(form_name)
end

def enter_form(inputs = {})
  inputs.each do |key, value|
    fill_in(key, with: value)
  end
end
