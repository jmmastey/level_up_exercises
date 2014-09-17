def enter_code_on_keypad(code)
  code = code.to_s
  code.each_char { |char| click_button(char) }
end
