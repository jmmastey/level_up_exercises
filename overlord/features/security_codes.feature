Feature: Security Codes
  In order to securely arm or disarm the bomb
  As a bomber
  I want to be able to enter security codes that change the status of the bomb

  @javascript
  Scenario: Deactivate an inactive bomb
    Given I am viewing an inactive bomb
    When I enter any code that is not the activation code 1 time
    Then nothing happens

  @javascript
  Scenario: Activate an inactive bomb
    Given I am viewing an inactive bomb
    When I enter the activation code
    Then the bomb is active

  @javascript
  Scenario: Deactivate an activated bomb
    Given I am viewing an active bomb
    When I enter the deactivation code
    Then the bomb is inactive

  @javascript
  Scenario: Activate an activated bomb
    Given I am viewing an active bomb
    When I enter the activation code
    Then nothing happens

  @javascript
  Scenario: Unsuccessfully deactivate an active bomb
    Given I am viewing an active bomb
    When I enter any code that is not the activation code 3 times
    Then the bomb is exploded

  @javascript
  Scenario: Interacting with an exploded bomb
    Given I am viewing an exploded bomb
    Then the security code form should be gone
