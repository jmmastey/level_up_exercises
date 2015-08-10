def shutdown_bomb
  visit 'configure_bomb'
  click_button 'Shutdown Bomb'
  visit 'configure_bomb'
end

def boot_bomb_with_default
  shutdown_bomb
  click_button 'Boot Bomb'
end

def arm_bomb_with_default
  boot_bomb_with_default
  fill_in("arming_code", with: '0000')
  click_button 'Arm This Bomb!'
end

def arm_bomb_for_disarming
  arm_bomb_with_default
  visit 'disarm_bomb'
end
