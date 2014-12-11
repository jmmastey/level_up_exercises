Feature: villain tries to deactivate an activated bomb
	
 	As a villain
 	I want to be able to deactivate a bomb
 	So that I can avoid blowing up at the wrong time

 	Background:
 		Given a bomb has been activated

 	Scenario: Deactivate Bomb
 		Given a bomb is activated
 		When I deactivate the bomb
 		Then I should see "Bomb deactivated"
 		And I should see a field to re-activate the bomb

	Scenario: Villain tries to deactivate a bomb 3 times incorrectly
		Given a bomb is activated
		When I try to deactivate the bomb
		And I try 3 times incorrectly
		Then the bomb should explode

# Feature: villain reactivates a deactivated bomb
# 	As a villain, I want to be able to reactivate a bomb 
# 	after I have deactivated it, in case I have change my mind

# 	Scenario: Villain re-activates a bomb
# 		Given a deactivated bomb
# 		When I re-activate it
# 		Then the bomb should be active
