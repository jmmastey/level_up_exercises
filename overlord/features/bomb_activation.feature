Feature: Activate a bomb

  Scenario: Activate a bomb with right activation code
    Given a bomb is "inactive"
    And I am looking at the page "activate"
    When I enter right "activation_code"
    Then bomb should be "active"

  Scenario: Activate a bomb with wrong activation code
    Given a bomb is "inactive"
    And I am looking at the page "activate"
    When I enter wrong "activation_code"
    Then bomb should be "inactive"

  Scenario: Activate a bomb with right activation code
    Given a bomb is "explode"
    And I am looking at the page "activate"
    When I enter right "activation_code"
    Then bomb should be "explode"

  Scenario Outline: Activate a bomb with invalid activation code
    Given a bomb is "inactive"
    And I am looking at the page "activate"
    When I enter invalid activation_code of <activation_code>
    Then bomb should be "inactive"

    Examples:
      | activation_code |
      | "asdf"          |
      | "    "          |