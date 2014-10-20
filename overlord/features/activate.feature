Feature: Activating the bomb
  As a super villain
  I want to activate the bomb
  So that I can blow up everything

  Scenario Outline: I activate the bomb
    Given I booted the bomb
    When I fill in "code" with "<code>"
    And I press "arm-button"
    Then I should see "<message>"

  @happy
  Examples:
    | code       | message                   |
    | 1234       | bomb status activated     |

  @sad
  Examples:
    | code       | message                   |
    | 4321       | bomb status not activated |

  @bad
  Examples:
    | code       | message                   |
    | 9876543210 | bomb status not activated |
    | zzzz       | bomb status not activated |
    |            | bomb status not activated |
