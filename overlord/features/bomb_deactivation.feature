Feature: Bomb deactivation
  In order to deactivate the bomb
  As the good Vault Boy
  I want to input the correct deactivation code

  Scenario: Set activation and deactivation codes
    Given I am on the bomb page
    When I set valid activation and deactivation codes
    Then I should be directed to the inactive_bomb page

  Scenario: Successful bomb activation
    Given I am on the inactive_bomb page
    When I input the correct activation code
    Then I should be directed to the active_bomb page
    And the page should contain Bomb Activated

  Scenario: Successful bomb deactivation
    Given I am on the active_bomb page
    When I input the correct deactivation code
    Then I should be directed to the inactive_bomb page
    And the page should contain You've Saved Megaton! For now...

  Scenario: Unsuccessful bomb deactivation
    Given I am on the active_bomb page
    When I input the incorrect deactivation code
    Then I should be directed to the active_bomb page
    And the page should contain The Bomb Is Still Active!

  Scenario: Unsuccessful deactivation leading to explosion
    Given I am on the active_bomb page
    When I input the incorrect deactivation code max times
    Then I should be directed to the explosion page
