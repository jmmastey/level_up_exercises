Feature: villain activates bomb
	
 	As a villain
 	I want to activate a bomb
 	So that I can have it explode

	Background:
		Given a bomb has been created

 	Scenario: Activate Bomb
		Given I'm on the inactive bomb page
		# More about how to arm bomb, negative test cases...
 		When I activate a bomb
 		Then I should be on a new page
 		And I should see "Bomb Status: ACTIVE"
