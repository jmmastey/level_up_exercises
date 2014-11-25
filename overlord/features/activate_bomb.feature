Feature: Activating the Bomb
  As a User
  I want to activate the bomb
  In order to make it explode

  Scenario: Use user activation code to activate bomb
    Given I have entered the activation and deactivation codes
    When I enter my correct activation code
    Then the bomb should be active

  Scenario: Use default activation code to activate bomb
    Given I am using the default codes
    When I enter the default activation code
    Then the bomb should be active

  Scenario: The bomb is still activated if the activation code is entered twice
    Given I have entered the activation and deactivation codes
    When I enter the correct activation code twice
    Then the bomb should be active
