Feature: Bomb activation and deactivation

  Scenario: super villian first finds the bomb
    Given the bomb page is loaded
    Then it is not activated

  Scenario: bomb activated with default code
    Given the bomb page is loaded
    When I input the default activation code
    Then the bomb is active

  Scenario: bomb activated with specified code
    Given the bomb page is loaded with specified
    When I input the specified activation code
    Then the bomb is active

  Scenario: bomb not activated with incorrect specified code
    Given the bomb page is loaded with specified
    When I input the wrong code
    Then it is not activated

  Scenario: bomb deactivated with default code
    Given the bomb page is loaded
    And I input the default activation code
    And the bomb is now active
    When I input the default deactivation code
    Then it is not activated

  Scenario: bomb deactivated with specified code
    Given the bomb page is loaded with specified
    And I input the specified activation code
    And the bomb is now active
    When I input the specified deactivation code
    Then it is not activated

  Scenario: bomb deactivated incorrectly
    Given the bomb page is loaded
    And I input the default activation code
    And the bomb is now active
    When I input an incorrect deactivation code
    Then the bomb is now active
    And the number of attempts remaining is 2

  Scenario: bomb deactivated incorrectly 3 times
    Given the bomb page is loaded
    And I input the default activation code
    And the bomb is now active
    When I input an incorrect deactivation code
    And I input an incorrect deactivation code
    And I input an incorrect deactivation code
    Then the bomb explodes

  Scenario: bomb started with a non numeric code
    Given the bomb page is loaded with non numeric
    Then I get an error
