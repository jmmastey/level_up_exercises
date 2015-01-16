
Given(/^the bomb is active$/) do
  @bomb = Overlord::Bomb.new
  @bomb.process_code('1234')
end
