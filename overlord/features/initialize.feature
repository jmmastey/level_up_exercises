Feature: activation interface
	As a supervillain
	I want to initialize a bomb with activation and deactivation code
	So I can wait until the right moment to activate it and defeat that pesky Spiderman

	Scenario: User views initialization interface before bomb is initialized
		Given The bomb has not been initialized
		When I go to the homepage
		Then I should see "Enter an activation code:"
		And I should see "Mwahahaha!"
		And I should see a "Bomb activation code" input box
		And I should see a "Bomb deactivation code" input box
		And I should see an "#initialize" submit button

	Scenario Outline: User initializes (but does not activate) bomb
		Given The bomb has not been initialized
		And I go to the homepage
		When I fill in "<activation>" as the activation code
		And I fill in "<deactivation>" as the deactivation code
		And I click the "Initialize" link
		Then I should see "The bomb is initialized with activation and deactivation codes, but is not active. Activate it with the correct code:"
		And I should see a "Bomb activation code" input box

		Scenarios:
			| activation      | deactivation        |
			| 1234            |  N/A   |
			| N/A              |  test  |
			|  N/A             | N/A    |
			| 3333            | 6666  |
