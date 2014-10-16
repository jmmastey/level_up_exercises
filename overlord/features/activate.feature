Feature: Activating the bomb
  As a super villain
  I want to activate the bomb
  So that I can blow up everything

  Scenario Outline: I activate the bomb
    Given I booted the bomb
    When I fill in "code" with "<code>"
    And I press "arm-button"
    Then I should see "<message>"

  Examples:
    | code | message                   |
    | 1234 | bomb status activated     |
    | 4321 | bomb status not activated |
    | zzzz | bomb status not activated |
    |      | bomb status not activated |
