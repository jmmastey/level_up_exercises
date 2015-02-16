Given /^(?:|A) bomb has already been activated$/ do
  bomb = Bombs.new
  bomb.activate
end

Given /^(?:|A) bomb has already been armed$/ do
  bomb = Bombs.new(:disarming_code => 1234, :max_attempts => 3)
  bomb.activate
  bomb.arm
end

Given /^(?:|A) bomb has already been disarmed$/ do
  bomb = Bombs.new(:disarming_code => 1234, :max_attempts => 3)
  bomb.activate
  bomb.arm
  bomb.disarm
end

Given /^(?:|A) bomb has already been detonated$/ do
  bomb = Bombs.new(:disarming_code => 1234, :max_attempts => 3)
  bomb.activate
  bomb.arm
  bomb.detonate
end

Given /^The bomb has a timer set to (\d+) seconds$/ do |timer|
  bomb = Bombs.first
  bomb.timer = timer
  bomb.save
end
