Feature: Bomb Deactivation
  In order to stop my evil plot
  As a super villain
  I want to be able to deactivate the bomb

  Background:
    Given the bomb is booted with codes "1234" and "0000"
    And the bomb is activated with code "1234"
    And I am on the home page

  @happy_path
  Scenario: Visit home poge
    Then I should see "The Bomb is Active"
    And I should see field "code"

  Scenario Outline: Deactivation codes entered
    When I fill in "Code" with "<code>"
    And I press "Enter"
    Then I should see "<message>"

    @happy_path
    Examples:
      | code | message              |
      | 0000 | Welcome to Your Bomb |

    @sad_path
    Examples:
      | code | message            |
      | 1111 | The Bomb is Active |

    @bad_path
    Examples:
      | code  | message            |
      | 0     | The Bomb is Active |
      | 00000 | The Bomb is Active |
      | a     | The Bomb is Active |
      | abcd  | The Bomb is Active |
      | abcge | The Bomb is Active |

  @happy_path
  Scenario: Invalid deactivation followed by valid
    When I enter code "1111" "2" times
    And I fill in "Code" with "0000"
    And I press "Enter"
    Then I should see "Welcome to Your Bomb"

  @sad_path
  Scenario: Valid deactivation code entered after time expired
    When I wait 31 seconds
    And I fill in "Code" with "0000"
    And I press "Enter"
    Then I should see "The Bomb Exploded"

  @sad_path
  Scenario: Invalid deactivation code entered 3 times
    When I enter code "1111" "3" times
    Then I should see "The Bomb Exploded"
