Feature: Activate Bomb

  Scenario: Entering default code to activate bomb
    Given I am using default activation code
    When I enter default activation code
    Then Bomb is activated

  Scenario: Entering customized code to activate bomb
    Given I am using customized activation code
    When I enter custom activation code
    Then Bomb is activated