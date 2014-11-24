Feature: Booting the Bomb

  Scenario: Visiting the home page
    When I go to the home page
    Then I should see a set activation code entry box
    And I should see a set de-activation code entry box
    And I should see a boot button

  Scenario: Set activation and deactivation codes and boot the bomb
    When I go to the home page
    And I set the activation code to 5678
    And I set the deactivation code to 9123
    And I click the Submit New Code and Boot button
    Then I should be on the bomb interface
    And the bomb should be deactivated

  Scenario: Do not set activation and deactivation codes and boot the bomb
    When I go to the home page
    And I click the Boot Bomb button
    Then I should be on the bomb interface
    And the bomb should be deactivated
