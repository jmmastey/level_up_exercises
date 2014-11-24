Feature: Activating the Bomb

  Scenario: Use user activation code
    Given I am on the home page
    When I set the activation code to 4444
    And I set the deactivation code to 8888
    And I click the Submit New Code and Boot button
    Then the bomb should be inactivated

  Scenario: Use user activation code to activate bomb
    Given I have entered the activation and deactivation codes
    When I enter 4444 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active

  Scenario: Use default activation code to activate bomb
    Given I am on the home page
    When I click the Boot Bomb button
    Then I should be on the bomb interface
    When I enter 1234 in the enter code box
    And I click the Enter Code button
    Then the bomb should be active

  Scenario: Use default activation code and enter wrong code
    Given I am on the home page
    When I click the Boot Bomb button
    And I enter 12343 in the enter code box
    And I click the Enter Code button
    Then the bomb should be inactivated
