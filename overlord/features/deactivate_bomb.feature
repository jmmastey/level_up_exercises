Feature: Deactive bomb
 
 Background:
    Given I have entered the activation and deactivation codes

  Scenario: The bomb deactivates if the correct deactivation code is entered
    Given the bomb is active
    When I enter my correct deactivation code
    Then the bomb should be deactivated state

  Scenario: deactivate the bomb with incorrect deactivate code
    Given the bomb is active
    When I enter my incorrecrt deactivation code
    Then the bomb should be active state

  Scenario: enter wrong deactivation code 3 times
    When I enter wrong deactivation code "4444" x3 times
    Then I should be on the exploaded page 