Feature: Create Bomb
  As a Super Villain
  I want to create a bomb
  so that it can be activated

  Scenario: Create a bomb
    Given no bomb is booted/created
    When I click on create button
    Then create a bomb
    And show a notification "Bomb is created"

  Scenario: Set default activation code
    Given activation code input is empty
    When I click on create button
    Then set activation code to 1234
    And show a notification "Bomb is created"

  Scenario: Set activation code from input
    Given activation code input is empty
    When I input an activation code "42"
    And I click on create button
    Then set the activation code to "42"
    And show a notification "Bomb is created"

  Scenario: Validate activation code from input
    Given activation code input is empty
    When I input an activation code "the answer"
    And I click on create button
    Then set the activation code to "the answer"
    And show a notification "Invalid Code"

  Scenario: Set default deactivation code
    Given deactivation code input is empty
    When I click on create button
    Then set deactivation code to "0000"
    And show a notification "Bomb is created"

  Scenario: Set deactivation code from input
    Given deactivation code input is empty
    When I input a deactivation code "1729"
    And I click on create button
    Then set deactivation code to "1729"
    And show a notification "Bomb is created"

  Scenario: Validate deactivation code from input
    Given deactivation code input is empty
    When I input a deactivation code "prime"
    And I click on create button
    Then set deactivation code to "prime"
    And show a notification "Invalid Code"
