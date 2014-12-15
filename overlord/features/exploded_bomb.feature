Feature: bomb explodes
	
	If you:
		1) leave an activated bomb for more than 30 seconds
		2) attempt to deactivate incorrectly 3 times or more
	then the bomb should explode
	
	Background:
		Given a bomb has been created and activated

 	Scenario: The bomb should go off by iteslf after 7 seconds
 		When I wait 7 seconds to do something
 		Then the bomb should have exploded
