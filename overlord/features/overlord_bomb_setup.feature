Feature: villain sets bomb up

  As a super villain
  I want to setup a bomb
  So that I can activate and deactivate it 

  Scenario: access setup interface 
    Given I have not yet setup the bomb
    When I access the bomb interface
    Then I should see "Status: Setup"
    And I should see an activation code field
    And I should see a deactivation code field

  Scenario: enter setup information
    Given I have accessed the bomb interface
    When I enter the activation code
    And I enter the deactivation code
    And I submit the setup information
    Then I should see "Status: Ready"
    And I should see "Enter activation code to activate:"
    And I should see an activation code field

  Scenario: use default setup information
    Given I have accessed the bomb interface
    When I submit the setup information
    Then I should see "Status: Ready"
    And I should see "Enter activation code to activate:"
    And I should see an activation code field

  Scenario: setup with invalid activation code
    Given I have accessed the bomb interface
    When I enter an invalid activation code
    And I submit the setup information
    Then I should see "Error: Invalid Activation Code"

  Scenario: setup with invalid deactivation code
    Given I have accessed the bomb interface
    When I enter an invalid deactivation code
    And I submit the setup information
    Then I should see "Error: Invalid Deactivation Code"
