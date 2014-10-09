Feature: Bomb Activation
  In order to rain on someone's parade
  As a super vilian
  I want to be able to activate the bomb

  Background:
    Given the bomb is booted with codes "1234" and "0000"
    And I am on the home page

  @happy_path
  Scenario: Visit home poge
    Then I should see "The Bomb is Booted"
    And I should see field "code"
    And the "time" field should contain "30"

  Scenario Outline: Activation codes entered
    When I fill in "Code" with "<code>"
    And I fill in "Time" with "<time>"
    And I press "Enter"
    Then I should see "<message>"
    And I should see field "<field>"

    @happy_path
    Examples:
      | code | time | message              | field |
      | 1234 | 30   | The Bomb is Active   | code  |
      | 1234 | 0    | The Bomb is Exploded |       |

    @sad_path
    Examples:
      | code | time | message            | field |
      | 2222 | 30   | The Bomb is Booted | code  |

    @bad_path
    Examples:
      | code | time | message              | field |
      | a    | 30   | The Bomb is Booted   | code  |
      | abcd | 30   | The Bomb is Booted   | code  |
      | 1    | 30   | The Bomb is Booted   | code  |
      | 1234 | a    | Invalid time entered |       |

  @happy_path
  Scenario Outline: Bomb timer causes the bomb to exploade
    When I fill in "Code" with "1234"
    And I fill in "Time" with "<time>"
    And I press "Enter"
    And I wait <delay> seconds
    And I go to the home page
    Then I should see "<message>"

    Examples:
      | time | delay | message        |
      | 30   | 31    | Bomb Exploded  |
      | 45   | 31    | Bomb is Active |
      | 30   | 29    | Bomb is Active |
