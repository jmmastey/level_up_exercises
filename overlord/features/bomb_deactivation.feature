Feature: Deactivate a bomb

  Scenario: Deactivate a bomb
    Given a bomb is "active"
    And I am looking at the page bomb
    When I enter right "deactivation_code"
    Then bomb should be "inactive"