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

  @happy
  Examples:
    | code | message                   |
    | 0000 | bomb status not activated |

  @sad
  Examples:
    | code | message                   |
    | 1234 | bomb status activated     |

  @bad
  Examples:
    | code | message                   |
    | zzzz | bomb status activated     |
    |      | bomb status activated     |

  @sad
  Scenario: I can't deactivate the bomb
    When I press "arm-button"
    And I press "arm-button"
    And I press "arm-button"
    Then I should see "bomb status exploded"
