Feature: Bomb deactivation
  In order to deactivate the bomb
  As the good Vault Boy
  I want to input the correct deactivation code

  Scenario: Visit the active_bomb page
    When I am on the active_bomb page
    Then I should see instructions and the form to submit the deactivation code

  Scenario: Successful bomb deactivation
    Given I have successfully activated the bomb
    When I input the correct deactivation code
    Then I should be directed to the inactive_bomb page
    And the page should contain You've Saved Megaton! For now...

  Scenario: Unsuccessful bomb deactivation
    Given I have successfully activated the bomb
    When I input the incorrect deactivation code
    Then I should be directed to the active_bomb page
    And the page should contain The Bomb Is Still Active!

  Scenario: Unsuccessful deactivation leading to explosion
    Given I have successfully activated the bomb
    When I input the incorrect deactivation code max times
    Then I should be directed to the explosion page
