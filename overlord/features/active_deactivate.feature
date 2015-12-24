Feature: Disarm active bomb
	As a supervillain
	I want to be able to disarm the bomb when activated
	So that I can stay alive if I accidentally activate it

	Scenario: User views disarm interface for an active bomb
		Given The bomb has been initialized
		And the bomb has been activated
		And I go to the homepage
		Then I should see "The bomb is active"
		And I should see a "Deactivate" link
		And I should see a "#bomb-deactivation-code" submit button

	Scenario: User enters correct deactivation code for an active bomb
		Given the bomb has been initialized with deactivation code "4444"
		And the bomb has been activated
		And I go to the homepage
		When I fill in "4444" as the deactivation code
		And I click the "Deactivate" link
		Then I should see "The bomb is initialized with activation and deactivation codes, but is not active. Activate it with the correct code:"

	Scenario: User enters incorrect deactivation code for an active bomb
		Given the bomb has been initialized with deactivation code "4444"
		And the bomb has been activated
		And I go to the homepage
		When I fill in "1111" as the deactivation code
		And I click the "Deactivate" link
		Then I should see "The bomb is active"
		And I should see "You have used 1 of 3 attempts at deactivating the bomb."
		And I should see a "Deactivate" link
		And I should see a "#bomb-deactivation-code" submit button 