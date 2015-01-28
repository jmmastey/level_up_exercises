Feature: Activate the bomb
  As a super-villian
  I want to activate the bomb
  So that someone can try to deactivate the bomb

  Scenario: Reach activation page
    Given the bomb has been booted with the default codes
    Then the bomb should not be activated yet
    And I should see a field to enter the activation code
    And I should see a button to submit the activation code

  Scenario: Bomb activates with default activation code
    Given the bomb has been booted with the default codes
  	When I enter the default activation code
    And I try to activate the bomb with the default code
  	Then the bomb should be activated

  Scenario: Bomb activates with custom activation code
    Given the bomb has been booted with "2222" as the activation code
    When I enter for the "2222" activation code
    And I try to activate the bomb
    Then the bomb should be activated

  Scenario: Bomb does not activate when wrong activation code is entered
    Given the bomb has been booted with the default codes
    When I enter an incorrect activation code
    And I try to activate the bomb
    Then the bomb should not be activated yet