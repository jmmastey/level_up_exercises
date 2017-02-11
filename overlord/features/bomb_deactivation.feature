Feature: Bomb deactivation

  Scenario: bomb deactivated with default code
    Given the bomb page is loaded
    And I input the default activation code
    When I input the default deactivation code
    Then it is not activated

  Scenario: bomb deactivated with specified code
    Given the bomb page is loaded with specified
    And I input the specified activation code
    When I input the specified deactivation code
    Then it is not activated

  Scenario: bomb deactivated incorrectly
    Given the bomb page is loaded
    And I input the default activation code
    When I input an incorrect deactivation code 1 times
    Then the bomb is now active
    And the number of attempts remaining is 2

  Scenario: bomb deactivated incorrectly 3 times
    Given the bomb page is loaded
    And I input the default activation code
    When I input an incorrect deactivation code 3 times
    Then the bomb explodes
