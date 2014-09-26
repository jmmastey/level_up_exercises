Feature: villain activates bomb

  As a villain
  I want to activate the bomb
  So I can blow up stuff

  Scenario Outline: activates the bomb
    Given I am on the start page
    When I fill in "activation_code" with "<act_code>"
    When I fill in "deactivation_code" with "<deact_code>"
    And I press "Arm the bomb"
    Then I should see "<result>"
  Examples:
    | act_code | deact_code | result                                               |
    | 1234     | 0000       | Bomb is armed                                        |
    | 1        | 0000       | Cannot arm bomb: activation code must be 4 numbers   |
    | 123      | 0000       | Cannot arm bomb: activation code must be 4 numbers   |
    | a        | 0000       | Cannot arm bomb: activation code must be 4 numbers   |
    |          | 0000       | Cannot arm bomb: activation code must be 4 numbers   |
    | asbc     | 0000       | Cannot arm bomb: activation code must be 4 numbers   |
    | 12345    | 0000       | Cannot arm bomb: activation code must be 4 numbers   |
    | 1234     | 1          | Cannot arm bomb: deactivation code must be 4 numbers |
    | 1234     | 123        | Cannot arm bomb: deactivation code must be 4 numbers |
    | 1234     | a          | Cannot arm bomb: deactivation code must be 4 numbers |
    | 1234     |            | Cannot arm bomb: deactivation code must be 4 numbers |
    | 1234     | 12346      | Cannot arm bomb: deactivation code must be 4 numbers |
    | 1234     | asbc       | Cannot arm bomb: deactivation code must be 4 numbers |


  Scenario: activation fails after bomb already activated
    Given I have already activated the bomb
    And I am on the start page
    When I fill in "activation_code" with "1234"
    When I fill in "deactivation_code" with "1234"
    And I press "Arm the bomb"
    Then I should see "already activated"

