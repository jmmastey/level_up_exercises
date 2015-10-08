Feature: Submitted a code

	Upon entry of any numeric code, the bomb respond accordingly.

	Scenario: bomb gets activated
	Given(/^I have entered the activation code$/) do
  		bomb = Bomb.new("1234", "0000", 3)

  		bomb.enter_code("1234")
	end

	Scenario: bomb gets deactivated
	Given(/^I have entered the deactivation code$/) do
  		bomb = Bomb.new("1234", "0000", 3)

  		bomb.enter_code("0000")
	end

	Scenario: bomb deactivation fails and tries count increases
	Given(/^I have entered the wrong deactivation code$/) do
  		bomb = Bomb.new("1234", "0000", 3)

  		bomb.enter_code("1332")
	end
