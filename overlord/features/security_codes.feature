Feature: Security Codes
  In order to securely arm or disarm the bomb
  As a bomber
  I want to be able to submit security codes that change the status of the bomb

  @javascript
  Scenario: Activate an inactive bomb
    Given I am viewing an inactive bomb
    When I submit the activation code
    Then the bomb is active

  @javascript
  Scenario: Attempt to activate an inactive bomb with the wrong code
    Given I am viewing an inactive bomb
    When I submit any code that is not the activation code
    Then I get an alert that says "The Activation Code you entered is incorrect"

  @javascript
  Scenario: Deactivate an activated bomb
    Given I am viewing an active bomb
    When I submit the deactivation code
    Then the bomb is inactive

  @javascript
  Scenario: Attempt to deactive an active bomb with the wrong code
    Given I am viewing an active bomb
    When I submit any code that is not the deactivation code
    Then I get an alert that says "The Deactivation code you entered is incorrect"

  @javascript
  Scenario: Bomb explodes
    Given I am viewing an active bomb
    When I submit any code that is not the deactivation code 3 times
    Then the bomb is exploded

  @javascript
  Scenario: Interacting with an exploded bomb
    Given I am viewing an exploded bomb
    Then the security code form should be gone
      And I should see a link to create a new bomb
