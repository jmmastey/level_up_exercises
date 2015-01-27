Feature: Activate a bomb

  @javascript
  Scenario: Activate a bomb
    Given a bomb is "inactive"
    And I am looking at the page bomb
    When I enter right "activation_code"
    Then bomb should be "active"
