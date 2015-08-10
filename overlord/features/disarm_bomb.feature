Feature: Disarm Bomb

  Scenario: Hero attempts to disarm a bomb that is not armed
    Given I am on the "disarm_bomb" page
    And I have a booted bomb with default values
    Then I should see "Bomb Status: Booted"
    And I should not see "Disarm bomb"

  Scenario: Hero disarms a bomb that is not armed
    Given I have an armed bomb ready to disarm
    And I am on the "disarm_bomb" page
    When I enter '1234' for "disarming_code"
    And I press "Disarm This Bomb!" within "disarm_bomb"
    Then I should see "You have disarmed the bomb"

  Scenario: The bomb is armed and I enter the incorrect disarming code
    Given I have an armed bomb ready to disarm
    And I am on the "disarm_bomb" page
    When I enter the wrong code three times
    Then I should see "You're dead!"
#
