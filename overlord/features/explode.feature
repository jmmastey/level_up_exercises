Feature: Bomb explosion
	As a supervillain
	I want the bomb to explode if someone tries to disarm it incorrectly 3 times
	So that only people who know the code can disarm it

	Scenario: User enters incorrect disarm code for the third time.
		Given the bomb has been initialized with deactivation code "4444"
		And the bomb has been activated
		When I enter an incorrect code three times
		Then I should see "The bomb exploded"