Feature: User cannot "hack" the bomb
  In order to use the bomb "effectively"
  As a user
  I should not be allowed to cheat

  Scenario: I try to view the "boom" page without arming the bomb
    Given I am on the arming page
    When I navigate to "/boom"
    Then I should see "This is a bomb"

  @arm @disarm
  Scenario: I am penalized when I try to view the "boom" page without forcing the bomb to explode
    When I navigate to "/boom"
    Then I should see "Nope, nope, nope, nope. You have 2 retries left"

  @arm @disarm
  Scenario: I am penalized when I try to deactivate the bomb by navigating back to the arming page
    When I navigate to "/"
    Then I should see "Nope, nope, nope, nope. You have 2 retries left"

  Scenario: I try to navigate to a non-existent page
    When I navigate to "/does-not-exist"
    Then I should see "This is a bomb"

  @arm @disarm
  Scenario: I cannot escape deactivation by navigating to a non-existent page when the bomb is armed and get penalized for trying
    When I navigate to "/does-not-exist"
    Then I should see "Nope, nope, nope, nope. You have 2 retries left"
