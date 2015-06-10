Feature: Explode
  As a user
  I want the bomb to explode
  In order to ruin christmas, and not be invited to kens birthday party anymore.

  Scenario: Explode: Timer exipration
    Given I have a newly active default bomb
    When 30 seconds has passed
    Then I should not see the status of the bomb
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should not be able to click any buttons
    And I should see an explosion

  Scenario: Explode: Too many attempts
    Given I have a active default bomb
    And I am on the bomb page
    And I use "DARBY" on the bomb
    And I use "DARBY" on the bomb
    When I use "DARBY" on the bomb
    Then I should not see the status of the bomb
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should not be able to click any buttons
    And I should see an explosion
