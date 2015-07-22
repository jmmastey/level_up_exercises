class TriggerPage < SitePrism::Page
  set_url '/trigger'

  element :trigger_code, 'input[id=trigger-code]'
  element :bomb_state, 'input[id=change-bomb-state]'
  element :notice, 'label[id=notice]'
  element :bomb_status, 'caption[id=bomb-status]'

  def enter_code(code)
    trigger_code.set(code)
  end

  def change_bomb_state
    bomb_state.click
  end
end
