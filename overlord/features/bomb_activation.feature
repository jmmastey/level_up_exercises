Feature: Bomb activation
  In order to destroy Megaton
  As the evil Vault Boy
  I want to activate the bomb

  Scenario: Successful bomb activation
    Given I am on the inactive_bomb page
    When I input the correct activation code
    Then I should be directed to the active_bomb page
    And the page should contain Bomb Activated

  Scenario: Unsuccessful bomb activation
    Given I am on the inactive_bomb page
    When I input the incorrect activation code
    Then I should be directed to the inactive_bomb page
    And the page should contain Please enter in the correct code, yo!

