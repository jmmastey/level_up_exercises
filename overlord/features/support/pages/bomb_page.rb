class BombPage < SitePrism::Page
  set_url '/'

  element :trigger_code, 'input[id=trigger-code]'
  element :bomb_state, 'input[id=change-bomb-state]'
  element :notice, 'label[id=notice]'

  def enter_code(code)
    trigger_code.set(code)
  end

  def change_bomb_state
    bomb_state.click
  end
end
