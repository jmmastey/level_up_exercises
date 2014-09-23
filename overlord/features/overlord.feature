Feature: Overlord Bomb-Status Page
  In order to test the Overlord bomb-status page
  As a developer who wrote Overlord
  I want to visit the page and verify all functionality

  Background:
    Given I create a bomb from the main page

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
    When I activate it and deactivate it
    Then I should see the bomb status page
    And the bomb should be intact
    And the bomb should not be activated
    And the deactivation attempts should be 0
    And the bomb message should be "Bomb deactivated"

  Scenario: I visit the main page, create a bomb, activate it, deactivate with wrong code
    When I activate it and unsuccessfully deactivate it 1 time
    Then I should see the bomb status page
    And the bomb should be intact
    And the bomb should be activated
    And the deactivation attempts should be 1
    And the bomb message should be "Wrong code"

  Scenario: I visit the main page, create a bomb, activate it, deactivate with wrong code twice
    When I activate it and unsuccessfully deactivate it 2 times
    Then I should see the bomb status page
    And the bomb should be intact
    And the bomb should be activated
    And the deactivation attempts should be 2
    And the bomb message should be "Wrong code"

  Scenario: I visit the main page, create a bomb, activate it, deactivate with wrong code thrice
    When I activate it and unsuccessfully deactivate it 3 times
    Then I should see the bomb status page
    And the bomb should be exploded
    And the bomb should have defunct activation
    And the deactivation attempts should be 3
    And the bomb message should be "Bomb exploded - too many attempts!"

  Scenario: I visit the main page, create a bomb, snip the wires
    When I click on snip 1 time
    Then I should see the bomb status page
    And the bomb should be snipped
    And the bomb should have defunct activation
    And the deactivation attempts should be 0
    And the bomb message should be "Bomb wires snipped and is now defunct"

  Scenario: I visit the main page, create a bomb, snip the wires twice
    When I click on snip 2 times
    Then I should see the bomb status page
    And the bomb should be snipped
    And the bomb should have defunct activation
    And the deactivation attempts should be 0
    And the bomb message should be "Sorry, bomb wires have been snipped."

  Scenario: I visit the main page, create a bomb, activate it, deactivate it, activate it
    When I activate it and deactivate it
	And I activate it
    Then I should see the bomb status page
    And the bomb should be intact
    And the bomb should be activated
    And the deactivation attempts should be 0

  Scenario: I visit the main page, create a bomb, activate it and detonate it
    When I activate it
    And I detonate the bomb
    Then I should see the bomb status page
    And the bomb should be exploded
    And the bomb should have defunct activation
    And the deactivation attempts should be 0
    And the bomb message should be "Bomb has been detonated!"
