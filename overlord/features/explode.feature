Feature: Explode the bomb
  As a super villain
  I want the bomb to explode
  So I can cause mayhem and destruction

  Scenario: Enter incorrect deactivation code thrice
    Given the bomb has been booted with default codes
    And the bomb has been activated
    When I submit an incorrect deactivation code 3 times
    Then I should be on the boom page
    And I should see "Boom!"
