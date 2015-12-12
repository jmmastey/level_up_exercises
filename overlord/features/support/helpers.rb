module Helpers

  def initialize_bomb(code_1, code_2)
    fill_in 'activation_code', with: code_1
    fill_in 'deactivation_code', with: code_2
    find("button[name='submit_button']").click
  end

  def validate_code(field_name, code)
    fill_in field_name, with: code
    find("button[name='submit_button']").click
  end

end

World(Helpers)
