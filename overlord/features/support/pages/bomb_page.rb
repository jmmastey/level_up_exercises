class BombPage < SitePrism::Page
  set_url "/bomb"

  element :instructions, "div.instructions"
  element :activation_code_field, "input[name='activation_code']"
  element :deactivation_code_field, "input[name='deactivation_code']"
  element :submit_button, "button[name='submit_button']"
end
