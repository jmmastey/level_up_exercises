Feature: Changing bomb activation

  Background:
    Given I have entered the activation and deactivation codes

  Scenario: The bomb is still activated if the activation code is entered twice
    When I enter 4444 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active
    When I enter 4444 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active

  Scenario: The bomb deactivates if the correct deactivation code is entered
    When I enter 8888 in the enter code box
    And I click the Enter Code button
    Then the bomb should be inactivated
