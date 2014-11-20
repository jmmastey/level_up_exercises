Feature: Activating the Bomb

  Scenario: Use default activation code
    Given I am on the home page
    When I click the boot bomb button
    And I enter 1234 in the enter code box
    Then the bomb should be activated
