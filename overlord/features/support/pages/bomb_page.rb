class BombPage < SitePrism::Page
  set_url '/'

  element :activation_code, 'input[id=activation-code]'
  element :activate_bomb, 'input[id=activate-bomb]'
  element :notice, 'label[id=notice]'

  def enter_valid_activation_code(code)
    activation_code.set(code)
    activate_bomb.click
  end
end
