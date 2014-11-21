Feature: Exploding the bomb

  Background:
    Given I have entered the activation and deactivation codes
    And the bomb is active

  Scenario: The bomb explodes if I enter the wrong deactivation code three times
    When I enter 0987 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active
    When I enter 0987 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active
    When I enter 0987 in the enter code box
    And I click the Enter Code button
    Then the bomb should be exploded

  Scenario: The bomb should deactivate if I enter the wrong deactivation code twice followed by the correct deactivation code
    When I enter 0987 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active
    When I enter 0987 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active
    When I enter 8888 in the enter code box
    And I click the Enter Code button
    Then the bomb should be inactivated
