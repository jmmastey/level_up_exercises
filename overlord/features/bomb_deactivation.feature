Feature: Deactivate a bomb

  Scenario: Deactivate a bomb with right deactivation code
    Given a bomb is "active"
    And I am looking at the page "deactivate"
    When I enter right "deactivation_code"
    Then bomb should be "inactive"

  Scenario: Deactivate a bomb with wrong deactivation code
    Given a bomb is "active"
    And I am looking at the page "deactivate"
    When I enter wrong "deactivation_code"
    Then bomb should be "active"

  Scenario: Deactivate a exploded bomb with right deactivation code
    Given a bomb is "explode"
    And I am looking at the page "deactivate"
    When I enter right "deactivation_code"
    Then bomb should be "explode"

  Scenario Outline: Activate a bomb with invalid deactivation code
    Given a bomb is "active"
    And I am looking at the page "deactivate"
    When I enter invalid deactivation_code of <deactivation_code>
    Then bomb should be "active"

    Examples:
      | deactivation_code |
      | "asdf"            |
      | "    "            |
