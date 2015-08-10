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
  fill_in('Enter Bomb Arming Code:', with: '0000')
  click_button 'Arm This Bomb!'
end

def arm_bomb_for_disarming
  arm_bomb_with_default
  visit 'disarm_bomb'
  fill_in('Enter Bomb Disarming Code:', with: '0000')
  click_button 'Disarm This Bomb'
end

def disarm_bomb_second_try
  arm_bomb_for_disarming
  fill_in('Enter Bomb Disarming Code:', with: '3333')
  click_button 'Disarm This Bomb'
  fill_in('Enter Bomb Disarming Code:', with: '3333')
  click_button 'Disarm This Bomb'
end

def create_armed_bomb
  shutdown_bomb
  click_button 'Boot Bomb'
  arm_bomb_for_disarming
  fill_in('Enter Bomb Arming Code:', with: '0000')
  click_button 'Arm This Bomb!'
  visit 'disarm_page'
end

def disarm_bomb_third_try
  create_armed_bomb
  fill_in('Enter Bomb Disarming Code:', with: '3333')
  click_button 'Disarm This Bomb'
  fill_in('Enter Bomb Disarming Code:', with: '3333')
  click_button 'Disarm This Bomb'
  fill_in('Enter Bomb Disarming Code:', with: '3333')
  click_button 'Disarm This Bomb'
end
