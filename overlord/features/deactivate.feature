Feature: Deactivating the bomb
  As a super villain
  I want to deactivate the bomb
  So that I can save my skin

  Background:
    Given I booted the bomb
    And I activated the bomb

  Scenario Outline: I deactivate the bomb
    When I fill in "code" with "<code>"
    And I press "arm-button"
    Then I should see "<message>"

  Examples:
    | code | message                   |
    | 0000 | bomb status not activated |
    | 1234 | bomb status activated     |
    | zzzz | bomb status activated     |
    |      | bomb status activated     |

  Scenario: I can't deactivate the bomb
    When I press "arm-button"
    And I press "arm-button"
    And I press "arm-button"
    Then I should see "bomb status exploded"
