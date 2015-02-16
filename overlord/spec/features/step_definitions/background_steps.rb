Given /^(?:|A) bomb has already been activated$/ do
  bomb = Bombs.new
  bomb.activate
end

Given /^(?:|A) bomb has already been deployed$/ do
  bomb = Bombs.new(:disarming_code => 1234, :max_attempts => 3)
  bomb.activate
  bomb.arm
end

Given /^The bomb has a timer set to (\d+) seconds$/ do |timer|
  bomb = Bombs.first
  bomb.timer = timer
  bomb.save
end
