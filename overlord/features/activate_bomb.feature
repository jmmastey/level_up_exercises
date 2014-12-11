Feature: villain activates bomb
	
 	As a villain
 	I want to activate a bomb
 	So that I can have it explode

	Background:
		Given a bomb has been created

 	Scenario: Activate Bomb
 		Given a bomb is created
 		When I activate a bomb
 		Then the bomb should be active
 		And I should see a field to deactivate the bomb
