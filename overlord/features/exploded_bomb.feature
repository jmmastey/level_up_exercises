Feature: bomb explodes

	As a villain
	I want to have a timer on the bomb
	so I can run away after I set it
	
	Background:
		Given a bomb has been created and activated with a 5 sec fuse

	# @long, or make this a variable so I can pass 0
	# Time customizable at bomb creation

 	Scenario: The bomb should go off by itself after 5 seconds
 		When I wait 7 seconds to do something
 		Then the bomb should have exploded

 	Scenario: I can deactivate it before 5 seconds
 		When I deactivate the bomb before 5 seconds have passed
 		Then the bomb should be deactivated
