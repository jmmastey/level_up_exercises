Feature: villain deactivates bomb

  As a villain
  I want to deactivate the bomb
  So I won't blow up stuff if I change my mind

  Scenario Outline: deactivate the bomb
    Given I have already activated with "<act>" and "<deact>"
    When I fill in "deactivation_code" with "<entry>"
    And I press "Deactivate"
    Then I should see "<result>"
  Examples:
    | act  | deact | entry | result                      |
    | 1234 | 0000  | 0000  | Bomb deactivated            |
    | 1234 | 0000  | 1234  | Incorrect deactivation code |

  Scenario: the bomb blows up on too many attempts
    Given I have already activated the bomb
    When I attempt to deactivate with the wrong code too many times
    Then I should see "boom"