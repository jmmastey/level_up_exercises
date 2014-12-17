Feature: villain creates bomb

	As a villain
	I want to create a bomb
	So that I can blow up my enemies

	Background: 
		Given I'm on the homepage
		And there is no bomb created yet

	Scenario: create bomb
		When I create a bomb
		Then I the bomb status should be Inactive

	Scenario: create bomb with no inputs
		When I create a bomb with no activation or deactivation code
		Then I should still see "Bomb Status: Inactive"

	Scenario: create bomb with only an activation code
		When I create a bomb with only an activation code
		Then I should still see "Bomb Status: Inactive"

	Scenario: create bomb with only a deactivation code
		When I create a bomb with only a deactivation code
		Then I should still see "Bomb Status: Inactive"
