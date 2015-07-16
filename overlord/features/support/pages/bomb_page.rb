class BombPage < SitePrism::Page
  set_url '/'

  element :activation_code, 'input[id=activation-code]'
  element :activate_bomb, 'input[id=activate-bomb]'

  def enter_valid_activation_code
    activation_code.set('1234')
    activate_bomb.click
  end
end
