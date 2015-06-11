Feature: Explode
  As a user
  I want the bomb to explode
  In order to ruin christmas, and not be invited to kens birthday party anymore.

  Scenario: Explode: Timer exipration
    Given I login as "villain"
    And I boot the bomb
    And I use 1234 on the bomb
    When the bomb timer runs out
    Then I should see an explosion
    And I should not see the status of the bomb
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should not be able to click any buttons

  Scenario: Explode: Too many attempts
    Given I login as "villain"
    And I boot the bomb
    And I use 1234 on the bomb
    And I use "DARBY" on the bomb
    And I use "DARBY" on the bomb
    When I use "DARBY" on the bomb
    Then I should see an explosion
    And I should not see the status of the bomb
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should not be able to click any buttons
