def boot_bomb_with_default
  visit 'boot_bomb'
  click_button 'Boot Bomb'
end

def shutdown_bomb
  visit 'shutdown_bomb'
  click_button 'Shutdown Bomb'
  visit 'boot_bomb'
end

def arm_bomb_with_default
  visit 'shutdown_bomb'
  click_button 'Shutdown Bomb'
  visit 'boot_bomb'
  click_button 'Boot Bomb'
  visit 'arm_bomb'
  fill_in( "arming_code", with: '0000')
  click_button 'Arm This Bomb!'
end