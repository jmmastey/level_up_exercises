Feature: Explode
  As a user
  I want the bomb to explode
  In order to ruin christmas, and not be invited to kens birthday party anymore.

  Scenario: Explode: Timer Exiration
    Given I have a newly active default bomb
    When 30 seconds has passed
    Then the bomb should explode

  Scenario: Explode: Too many attempts
    Given I have a active default bomb
    And I am on the bomb page
    And the bomb has 1 attempt remaining
    When I use "DARBY" on the bomb
    Then the bomb should explode
    