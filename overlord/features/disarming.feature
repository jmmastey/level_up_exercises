Feature: Disarming the bomb
  In order to disarm the bomb
  As a user
  I should enter a valid deactivation code

  @arm
  Scenario: I enter a valid deactivation code
    When I fill in "deactivation_code" with "1234"
    And I click "submit"
    Then I should see "Bomb successfully deactivated"

  @arm @disarm
  Scenario: I enter a invalid deactivation code
    When I fill in "deactivation_code" with "123"
    And I click "submit"
    Then I should see "Nope, nope, nope, nope. You have 2 retries left"

  @arm
  Scenario: I enter an invalid deactivation code 3 times
    When I fill in "deactivation_code" with "first_try"
    And I click "submit"
    Then I should see "Nope, nope, nope, nope. You have 2 retries left"
    When I fill in "deactivation_code" with "first_try"
    And I click "submit"
    Then I should see "Nope, nope, nope, nope. You have 1 retries left"
    When I fill in "deactivation_code" with "first_try"
    And I click "submit"
    Then I should see "Boom, be*ch!"
