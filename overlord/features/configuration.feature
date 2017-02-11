Feature: Code configurations
  In order to activate the bomb
  As the evil Vault Boy
  I want to input the correct activation code

  Scenario: Visit the bomb page
    When I am on the bomb page
    Then I should see instructions and the form to set and submit codes

  Scenario: Set a blank activation code with a valid deactivation code
    Given I am on the bomb page
    When I set a blank activation code
    Then I should be directed to the bomb page
    And the page should contain Input must not be blank.

  Scenario: Set a blank deactivation code with a valid activation code
    Given I am on the bomb page
    When I set a blank activation code
    Then I should be directed to the bomb page
    And the page should contain Input must not be blank.

  Scenario: Set blank duplicate activation and deactivation codes
    Given I am on the bomb page
    When I set blank activation or deactivation codes
    Then I should be directed to the bomb page
    And the page should contain Input must not be blank.

  Scenario: Set valid activation and deactivation codes
    Given I am on the bomb page
    When I set valid activation and deactivation codes
    Then I should be directed to the inactive_bomb page

  Scenario: Set an invalid activation code with a valid deactivation code
    Given I am on the bomb page
    When I set an invalid activation code with a valid deactivation code
    Then I should be directed to the bomb page
    And the page should contain Codes can only be numeric.

  Scenario: Set a valid activation code with an invalid deactivation code
    Given I am on the bomb page
    When I set a valid activation code with an invalid deactivation code
    Then I should be directed to the bomb page
    And the page should contain Codes can only be numeric.

  Scenario: Set invalid duplicate activation and deactivation codes
    Given I am on the bomb page
    When I set invalid duplicate activation and deactivation codes
    Then I should be directed to the bomb page
    And the page should contain Codes must be different.
    And the page should contain Codes can only be numeric.

  Scenario: Set valid duplicate activation and deactivation codes
    Given I am on the bomb page
    When I set valid duplicate activation or deactivation codes
    Then I should be directed to the bomb page
    And the page should contain Codes must be different.