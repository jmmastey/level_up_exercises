def enter_code_on_keypad(code = nil)
  unless code.nil?
    code = code.to_s
    code.each_char { |char| click_button(char) }
  end

  find_by_id("btn-enter").click
end
