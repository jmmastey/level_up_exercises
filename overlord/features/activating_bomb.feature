Feature: Booting the Bomb

  Scenario: Visiting the home page
    When I go to the home page
    Then I should see a set activation code entry box
    And I should see a boot button

  Scenario: Set activation code and boot the bomb
    When I go to the home page
    And I set the activation code to 5678
    And I click the boot bomb button
    Then I should be on the bomb interface

  Scenario: Do not set activation code and boot the bomb
