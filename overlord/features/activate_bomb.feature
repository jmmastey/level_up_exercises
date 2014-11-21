Feature: Activating the Bomb

  Scenario: Use user activation code
    Given I am on the home page
    When I set the activation code to 4444
    And I set the deactivation code to 8888
    And I click the Submit New Code and Boot button
    Then the bomb should be active

  Scenario: Use user activation code and reenter same code
    Given I am on the home page
    When I set the activation code to 4444
    And I set the deactivation code to 8888
    And I click the Submit New Code and Boot button
    Then the bomb should be active
    And I enter 1234 in the enter code box

  Scenario: Use default activation code
    Given I am on the home page
    When I click the Boot Bomb button
    And I enter 1234 in the enter code box
    Then the bomb should be active

  Scenario: Use default activation code and enter wrong code
    Given I am on the home page
    When I click the Boot Bomb button
    And I enter 12343 in the enter code box
    Then the bomb should be active
