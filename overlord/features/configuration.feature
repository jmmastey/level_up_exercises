Feature: Code configurations
  In order to activate the bomb
  As the evil Vault Boy
  I want to input the correct activation code

  Scenario: Set blank duplicate activation and deactivation codes
    Given I am on the bomb page
    When I set blank activation or deactivation codes
    Then I should be directed to the bomb page
    And the page should contain Input must not be blank.

  Scenario: Set valid activation and deactivation codes
    Given I am on the bomb page
    When I set valid activation and deactivation codes
    Then I should be directed to the inactive_bomb page

  Scenario: Set invalid activation and deactivation codes
    Given I am on the bomb page
    When I set invalid activation or deactivation codes
    Then I should be directed to the bomb page
    And the page should contain Codes can only be numeric.

  Scenario: Set invalid duplicate activation and deactivation codes
    Given I am on the bomb page
    When I set invalid duplicate activation or deactivation codes
    Then I should be directed to the bomb page
    And the page should contain Codes must be different.