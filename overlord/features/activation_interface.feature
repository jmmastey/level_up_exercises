Feature: activation interface
	As a supervillain
	I want to activate a bomb
	So I can defeat my nemesis

	Scenario: inactive bomb can be activated and deactivated

	Scenario: View activation interface
		Given The bomb has not been initialized
		When I go to the homepage
		Then I should see "Enter an activation code:"
		And I should see "Mwahahaha!"
		And I should see a "Bomb activation code" input box
		And I should see a "Bomb deactivation code" input box
		And I should see an "#activate" submit button


	Scenario Outline: customer activates bomb

		Given The bomb has not been initialized
		And I go to the homepage
		When I fill in "<activation>" as the activation code
		And I fill in "<deactivation>" as the deactivation code
		And I click the "Activate!!!" link
		And I should see "Enter activation code to activate bomb:"
		And I should see a "Bomb activation code" input box
		And I should see "The bomb is inactive"

		Scenarios:
			| activation      | deactivation        |
			| 1234            |  N/A   |
			| N/A              |  test  |
			|  N/A             | N/A    |
			| 3333            | 6666  |


	Scenario:
		Given The bomb has been activated
		And I go to the bomb active page
		Then I should see "You set the bomb!"
		And I should see "Disarm:"
		And I should see a "Disarm" input box

	Scenario:
		Given The bomb has been activated
		And I go to the homepage
		Then I should see "The bomb is active"
		And I should see a "Disarm" link

	Scenario:
		Given 
		
