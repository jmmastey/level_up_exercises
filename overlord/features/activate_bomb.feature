Feature: Activating the Bomb
  As a User
  I want to activate the bomb
  In order to make it explode

  Scenario: Use user activation code to activate bomb (Happy Path)
    Given I have entered the activation and deactivation codes
    When I enter my correct activation code
    Then the bomb should be active

  Scenario: Use default activation code to activate bomb (Happy Path)
    Given I am using the default codes
    When I enter the default activation code
    Then the bomb should be active

  Scenario: The bomb is still deactivated if the deactivation code is entered when the bomb is deactivated (Sad Path)
    Given I am using the default codes
    When I enter my correct deactivation code
    Then the bomb should be deactivated

  Scenario: The bomb is still activated if the activation code is entered twice (Sad Path)
    Given I have entered the activation and deactivation codes
    When I enter the correct activation code twice
    Then the bomb should be active
