Feature: villain activates bomb

  As a villain
  I want to activate a bomb
  So that I can blow things up

  Scenario: activate bomb with correct code
    Given I have setup the bomb
    When I activate the bomb with the correct code
    Then I should see "Status: Activated"
    And I should see a deactivation code field

  Scenario: activate bomb with incorrect code
    Given I have setup the bomb
    When I activate the bomb with an incorrect code
    Then I should see "Status: Ready"
    And I should see "Error: Invalid Activation Code"

  Scenario: activate bomb with default code
    Given I have setup the bomb with defaults
    When I activate the bomb with the default code
    Then I should see "Status: Activated"
    And I should see a deactivation code field
