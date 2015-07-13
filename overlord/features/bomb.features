Feature: Bomb
  Scenario: Homepage
    Given I am viewing "/"
    Then I should see an unbooted bomb

  Scenario: Activate Bomb
    Given I can see the unbooted bomb
      And I boot the bomb with default codes
    When I enter the default activation key
    Then The bomb is activated

  Scenario: Boot with custom and fail to activate
    Given I can see the unbooted bomb
      And I boot the bomb with 3123 and 0123
    When I enter the default activation key
    Then The bomb is not activated

  Scenario: Activate Bomb with custom key
    Given I can see the unbooted bomb
      And I boot the bomb with 3123 and 0123
    When I enter 3123
    Then The bomb is activated

  Scenario: Activate and Dectivate Bomb with custom keys
    Given I can see the unbooted bomb
      And I boot the bomb with 1111 and 4444
    When I enter 1111
    And I enter 4444
    Then the bomb is not activated
