Feature: Flash messages
  In order to prevent notices from popping up on page refreshes
  I use flash

  @arm
  Scenario: I only see the deactivated message once on deactivation
    When I fill in "deactivation_code" with "1234"
    And I click "submit"
    Then I should see "Bomb successfully deactivated"
    When I refresh the page
    Then I should not see "Bomb successfully deactivated"

  @arm @disarm
  Scenario: I only see the retry message once per misstep
    When I fill in "deactivation_code" with "123"
    And I click "submit"
    Then I should see "Nope, nope, nope, nope. You have 2 retries left"
    When I refresh the page
    Then I should not see "Nope, nope, nope, nope. You have 2 retries left"
