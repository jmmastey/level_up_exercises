Feature: Bomb activation

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

  Scenario: bomb started with a non numeric code
    Given the bomb page is loaded with non numeric
    Then I get an error
