
Given(/^the bomb is active$/) do
  @bomb = Overlord::Bomb.new
  @bomb.process_code('1234')
end

Given(/^the bombs activation code is updated$/) do
  @bomb = Overlord::Bomb.new
  @bomb.update_activation_code('4567')
end

Given(/^the bombs deactivation code is updated$/) do
  @bomb = Overlord::Bomb.new
  @bomb.update_deactivation_code('0007')
end
