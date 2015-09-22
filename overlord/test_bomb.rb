require_relative "lib/bomb"

foo_bomb = Bomb.new("1122", "3333")
puts foo_bomb.state
puts foo_bomb.enter_code("1122").error.nil?
puts foo_bomb.foobar
abort "xx"