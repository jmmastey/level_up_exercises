class InactiveBombPage < SitePrism::Page
  set_url "/inactive_bomb"

  element :instructions, "div.instructions"
  element :activation_code_field, "input[name='activation_code']"
  element :submit_button, "button[name='submit_button']"
end
