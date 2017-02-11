Feature: Submitted a code

	Upon entry of any numeric code, the bomb respond accordingly.
#capybara here
@happy
	Scenario: Activating the bomb
	Given I want to activate the bomb
	When I enter the activation code '1234'
	Then the bomb should be active

#old cucumber
@happy
	Scenario: bomb gets deactivated
	Given(/^I have entered the deactivation code$/) do
  		bomb = Bomb.new("1234", "0000", 3)

  		bomb.enter_code("0000")
	end

@sad
	Scenario: bomb deactivation fails and tries count increases
	Given(/^I have entered the wrong deactivation code$/) do
  		bomb = Bomb.new("1234", "0000", 3)
  		bomb.enter_code("1332")
	end


@bad
	Scenario: I enter garbage as a code
	Given I want to activate the bomb
	When I enter the activation code 'sdfsdfsf'
	Then the bomb should tell me I am an idiot
	