Feature: villain creates bomb

	As a villain
	I want to create a bomb
	So that I can blow up my enemies

	Scenario: create bomb
		Given I'm on the homepage
		And there is no bomb created yet
		When I create a bomb
		Then I should see "Bomb Status: Inactive"
