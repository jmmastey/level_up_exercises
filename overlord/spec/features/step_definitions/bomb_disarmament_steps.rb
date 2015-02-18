When /^The timer runs out$/ do
  bomb = Bombs.first
  timer = bomb.timer
  sleep(timer + 3)
end
