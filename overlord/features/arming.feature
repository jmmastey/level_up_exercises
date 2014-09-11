Feature: Arming the bomb
  In order to arm the bomb
  As a user
  I need to type in a valid activation code
  And optionally a timer value

  Scenario: View bomb arming page
    Given I am on the arming page
    Then I should see "This is a bomb"

  @disarm
  Scenario: Arming the bomb with a valid code
    Given I am on the arming page
    When I fill in "activation_code" with "1234"
    And I click "submit"
    Then I should see "Bomb armed. You have 30 seconds left!"

  Scenario: Arming the bomb with an invalid code
    Given I am on the arming page
    When I fill in "activation_code" with "123"
    And I click "submit"
    Then I should see "This is a bomb"
