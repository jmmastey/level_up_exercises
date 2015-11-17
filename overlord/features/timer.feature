Feature: Bomb Timer

  Scenario: Timer is not active until bomb is activated
    Given that the bomb is booted
    Then I should not see the timer

  @javascript
  Scenario: Timer initially has 5:00 once bomb is activated
    Given that the bomb is booted
    When I enter the default activation code
    And I confirm the activation
    Then there should be 5:00 left on the timer

  @javascript
  Scenario: Timer decrements automatically
    Given that the bomb is booted
    When I enter the default activation code
    And I confirm the activation
    And I wait 3 seconds
    Then there should be 4:57 left on the timer
