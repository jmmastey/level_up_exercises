Feature: Overlord Bomb-Status Page
  In order to test the Overlord bomb-status page
  As a developer who wrote Overlord
  I want to visit the page and verify all functionality

  Background:
    Given I visit the main page
    When I click the Create button

  Scenario: I visit the main page and click create-bomb
    Then I should see the bomb status page
	And the bomb should be intact
    And the bomb should not be activated

  Scenario: I visit the main page, create a bomb, activate it
    When I select code 1234
    And I press activate
	Then I should see the bomb status page
	And the bomb should be intact
    And the bomb should be activated

  Scenario: I visit the main page, create a bomb, activate it, deactivate it
    When I select code 1234
    And I press activate
    And I select code 0000
    And I press deactivate
	Then I should see the bomb status page
	And the bomb should be intact
    And the bomb should not be activated
    And the deactivation attempts should be 0
    And the bomb message should be "Bomb deactivated"

  Scenario: I visit the main page, create a bomb, activate it, deactivate with wrong code
    When I select code 1234
    And I press activate
    And I select code 0009
    And I press deactivate
	Then I should see the bomb status page
	And the bomb should be intact
    And the bomb should be activated
    And the deactivation attempts should be 1
    And the bomb message should be "Wrong code"

  Scenario: I visit the main page, create a bomb, activate it, deactivate with wrong code twice
    When I select code 1234
    And I press activate
    And I select code 0009
    And I press deactivate
    And I select code 0009
    And I press deactivate
	Then I should see the bomb status page
	And the bomb should be intact
    And the bomb should be activated
    And the deactivation attempts should be 2
    And the bomb message should be "Wrong code"

  Scenario: I visit the main page, create a bomb, activate it, deactivate with wrong code thrice
    When I select code 1234
    And I press activate
    And I select code 0009
    And I press deactivate
    And I select code 0009
    And I press deactivate
    And I select code 0009
    And I press deactivate
	Then I should see the bomb status page
	And the bomb should be detonated
    And the bomb should have defunct activation
    And the deactivation attempts should be 3
    And the bomb message should be "Bomb detonated - too many attempts!"

  Scenario: I visit the main page, create a bomb, snip the wires
    When I click on snip
	Then I should see the bomb status page
	And the bomb should be snipped
    And the bomb should have defunct activation
    And the deactivation attempts should be 0
    And the bomb message should be "You have snipped the wires - bomb is now defunct"

  Scenario: I visit the main page, create a bomb, snip the wires twice
    When I click on snip
    When I click on snip
	Then I should see the bomb status page
	And the bomb should be snipped
    And the bomb should have defunct activation
    And the deactivation attempts should be 0
    And the bomb message should be "Sorry, bomb wires have been snipped."

  Scenario: I visit the main page, create a bomb, activate it, deactivate it, activate it
    When I select code 1234
    And I press activate
    And I select code 0000
    And I press deactivate
    And I select code 1234
    And I press activate
	Then I should see the bomb status page
	And the bomb should be intact
    And the bomb should be activated
    And the deactivation attempts should be 0
