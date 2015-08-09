require "./fraction.rb"
require "net/http"

x = Fraction.new(5, 9)
y = Fraction.new(1, 6)
z = x + y
puts "The sum of #{x} and #{y} is #{z}"

x.load("http://localhost:8080")
puts "Random fraction from server: #{x}"
