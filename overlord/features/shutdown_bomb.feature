Feature: Villain shuts down a bomb

  Scenario: Villain shuts down a bomb that not booted
    Given I am on the "configure_bomb" page
    When  I press "Shutdown" within "configure_bomb"
    Then  I should see "Not Booted"

  Scenario: Villain shuts down a bomb that is booted
    Given I am on the "configure_bomb" page
    And I have a booted bomb with default values
    When  I press "Shutdown" within "configure_bomb"
    Then  I should see "Not Booted"

  Scenario: Villain shuts down a bomb that is armed
    Given I am on the "configure_bomb" page
    And I have an armed bomb with default values
    When  I press "Shutdown" within "configure_bomb"
    Then  I should see "Not Booted"