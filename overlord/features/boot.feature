Feature: Boot Bomb
  In order to achive world domination
  As a super vilian
  I want to be able to boot my bomb

  Background:
    Given the bomb is not yet booted
    And I am on the home page

  @happy_path
  Scenario: Visit home page
    Then I should see "Welcome to Your Bomb"
    And I should see "Let's boot the bomb!"

  @happy_path
  Scenario: Boot bomb with default codes
    When I press "Boot"
    Then I should see "The Bomb is Booted Up"
    And I should see field "code"

  Scenario Outline: Boot bomb with various codes
    When I fill in "Activation Code" with "<activation>"
    And I fill in "Deactivation Code" with "<deactivation>"
    And I press "Boot"
    Then I should see "<message>"
    And I should see field "<field>"

    @happy_path
    Examples:
      | activation | deactivation | message               | field |
      | 4321       | 9999         | The Bomb is Booted Up | code  |

    @sad_path
    Examples:
      | activation | deactivation | message               | field |
      | 22         | 9999         | Invalid codes entered |       |
      | 43210      | 9999         | Invalid codes entered |       |
      | 4321       | 11           | Invalid codes entered |       |
      | 4321       | 99999        | Invalid codes entered |       |

    @bad_path
    Examples:
      | activation | deactivation | message               | field |
      | a          | 9999         | Invalid codes entered |       |
      | abcd       | 9999         | Invalid codes entered |       |
      | 4321       | x            | Invalid codes entered |       |
      | 4321       | xyzz         | Invalid codes entered |       |
