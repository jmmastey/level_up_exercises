class ActiveBombPage < SitePrism::Page
  set_url "/active_bomb"

  element :instructions, "div.instructions"
  element :deactivation_code_field, "input[name='deactivation_code']"
  element :submit_button, "button[name='submit_button']"
end
