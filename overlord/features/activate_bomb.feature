Feature: activate the bomb

  In order to start the bomb
  As the Overlord
  I should enter the activation code.

  Scenario: successfully boot the bomb
    Given I am on the bomb home page
    When I submit valid codes
    Then I see the bomb has successfully booted

  Scenario: enter the correct activation code to start the bomb
    Given I successfully boot the bomb
    When I submit the correct activation code
    Then I see the bomb timer start

  Scenario: enter a wrong (but valid) activation code and do not start the bomb
    Given I successfully boot the bomb
    When I submit incorrect activation code
    Then I see an error message 
    And I see a prompt to activate

  Scenario: enter invalid activation code and do not start the bomb
    Given I successfully boot the bomb
    When I submit an invalid activation code
    Then I see an error message
    And I see a prompt to activate

