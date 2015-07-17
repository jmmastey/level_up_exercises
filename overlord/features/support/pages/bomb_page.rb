class BombPage < SitePrism::Page
  set_url '/'

  element :activation_code, 'input[id=activation-code]'
  element :deactivation_code, 'input[id=deactivation-code]'
  element :activate_bomb, 'input[id=activate-bomb]'
  element :deactivate_bomb, 'input[id=deactivate-bomb]'
  element :notice, 'label[id=notice]'

  def enter_valid_activation_code(code)
    activation_code.set(code)
  end

  def enter_valid_deactivation_code(code)
    deactivation_code.set(code)
  end
end
