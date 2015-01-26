Feature: villain deactivates bomb

  As a villain
  I want to deactivate an activated bomb
  So that I can change my mind about blowing things up

  Scenario: deactivate bomb with correct code
    Given I have an activated bomb
    When I enter the correct deactivation code
    Then I should see "Status: Ready"

  Scenario: deactivate bomb with incorrect code
    Given I have an activated bomb
    When I enter the incorrect deactivation code
    Then I should see "Status: Activated"
    And I should see "Error: Invalid Deactivation Code"

  Scenario: deactivate bomb with incorrect code too many times
    Given I have an activated bomb
    When I enter the incorrect deactivation code too many times
    Then I should see "BOOM"

  Scenario: deactivate bomb with default code
    Given I have an activated bomb setup with defaults
    When I enter the default deactivate code
    Then I should see "Status: Ready"
