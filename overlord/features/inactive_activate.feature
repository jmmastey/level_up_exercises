Feature: Bomb activation
	As a supervillain
	I want to activate an initialized but inactive bomb
	So I can defeat my web-and-joke-slinging nemesis Spiderman
	And rid the world of his AWFUL jokes

	Scenario: User views interface to activate bomb after bomb has been initialized
		Given The bomb has been initialized
		When I go to the homepage
		Then I should see "The bomb is initialized with activation and deactivation codes, but is not active. Activate it with the correct code:"
		And I should see a "Bomb activation code" input box
		And I should see an "#activate" submit button

	Scenario: User activates an initialized but inactive bomb
		Given the bomb has been initialized with activation code "1000"
		And I go to the homepage
		When I fill in "1000" as the activation code
		And I click the "Activate" link
		Then I should see "The bomb is active!"
		And I should see "Deactivate"
		And I should see a "Deactivate" link
		And I should see a "#deactivate" submit button
		
	Scenario: User enters an incorrect activation code for an initialized, inactive bomb
		Given the bomb has been initialized with activation code "1000"
		And I go to the homepage
		When I fill in "2222" as the activation code
		And I click the "Activate" link
		Then I should see "The bomb is initialized with activation and deactivation codes, but is not active. Activate it with the correct code:"
		And I should see a "Bomb activation code" input box
		And I should see an "#activate" submit button
