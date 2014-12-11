Feature: villain creates bomb

	As a villain
	I want to create a bomb
	So that I can blow up my enemies

	Scenario: create bomb
		Given there is no bomb created yet
		When I create a bomb
		Then the bomb should be created
		# And I should see "Acivate Bomb?"

# Feature: villain activates bomb
	
# 	As a villain
# 	I want to activate a bomb
# 	So that I can have it explode

# 	Scenario: Activate Bomb
# 		Given a bomb is created
# 		When I activate a bomb
# 		Then the bomb should be active
# 		And I should see a field to deactivate the bomb

# Feature: villain tries to deactivate an activated bomb
	
# 	As a villain
# 	I want to be able to deactivate a bomb
# 	So that I can avoid blowing up at the wrong time....

# 	Scenario: Deactivate Bomb
# 		Given a bomb is activated
# 		When I deactivate the bomb
# 		Then I should see "Bomb deactivated"
# 		And I should see a field to re-activate the bomb

# 	Scenario: Villain tries to deactivate a bomb 3 times incorrectly
# 		Given a bomb is activated
# 		When I try to deactivate the bomb
# 		And I try 3 times incorrectly
# 		Then the bomb should explode

# Feature: villain reactivates a deactivated bomb
# 	As a villain, I want to be able to reactivate a bomb 
# 	after I have deactivated it, in case I have change my mind

# 	Scenario: Villain re-activates a bomb
# 		Given a deactivated bomb
# 		When I re-activate it
# 		Then the bomb should be active
