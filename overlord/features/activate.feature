Feature: Activate
  As a villain
  I want to be able to activate the bomb
  In order to intensify extortion

  Scenario: Confirmation button exists
    Given the bomb has been booted with default settings
    And I am on the bomb page
    When I use 1234 on the bomb
    Then I should see a "confirm" button

  Scenario: Bailing on confirmation should not activate the bomb
    Given the bomb has been booted with default settings
    And I am on the bomb page
    And I use 1234 on the bomb
    When I click the "cancel" button
    Then I should see the status of the bomb as "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Activate Bomb: Default Success
    Given the bomb has been booted with default settings
    And I am on the bomb page
    And I use 1234 on the bomb
    When I click the "confirm" button
    Then I should see the status of the bomb as "Active"
    And I should see the remaining defusal attempts is 3
    And I should see a bomb timer

  Scenario: Activate Bomb: Default Failure
    Given the bomb has been booted with default settings
    And I am on the bomb page
    And I use 666 on the bomb
    When I click the "confirm" button
    Then I should see the status of the bomb as "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should see "Invalid Activation Code"

  Scenario: Validate Activation Code is Numeric
    Given the bomb has been booted with default settings
    And I am on the bomb page
    When I use "STAHP" on the bomb
    Then I should see the status of the bomb as "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should see "Activation codes must be numeric"

  Scenario: Activate Bomb: Positive Custom Success 
    Given the bomb has been booted with and activation code of 666
    And I am on the bomb page
    And I use 666 on the bomb
    When I click the "confirm" button
    Then I should see the status of the bomb as "Active"
    And I should see the remaining defusal attempts is 3
    And I should see a bomb timer

  Scenario: Activate Bomb: Negative Custom Success 
    Given the bomb has been booted with and activation code of 666
    And I am on the bomb page
    And I use 1234 on the bomb
    When I click the "confirm" button
    Then I should see the status of the bomb as "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should see "Invalid Activation Code"
