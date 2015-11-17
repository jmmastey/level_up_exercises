Feature: Bomb Activation

  Scenario: Activate bomb with default key
    Given that the bomb is booted
    When I enter the default activation code
    Then the bomb should be in a Activated state

  Scenario: Activate bomb with custom key
    Given that the bomb is booted with a custom activation key
    When I enter the custom activation code
    Then the bomb should be in a Activated state

  Scenario: Deactivation key must be valid
    When I enter an invalid activation code
    Then I should see a "Activation Code must be a 4-digit number" error

  Scenario: Activation requires entering the activation key
    Given that the bomb is booted with a custom activation key
    When I enter the default activation code
    Then the bomb should be in a Deactivated state

  Scenario: Activating when activated has no additional effect
    Given that the bomb is booted
    And the bomb has been activated
    When I enter the default activation code
    Then the bomb should be in a Activated state


  @javascript
  Scenario: Activation waiting for confirmation
    Given that the bomb is booted
    When I enter the default activation code
    Then the bomb overview page should not be changeable
    And the bomb should be in a Deactivated state

  @javascript
  Scenario: Activation cancellation
    Given that the bomb is booted
    When I enter the default activation code
    And I cancel the activation
    Then the bomb should be in a Deactivated state

  @javascript
  Scenario: Activation confirmation
    Given that the bomb is booted
    When I enter the default activation code
    And I confirm the activation
    Then the bomb should be in a Activated state
