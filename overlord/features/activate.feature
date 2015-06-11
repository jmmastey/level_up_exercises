Feature: Activate
  As a villain
  I want to be able to activate the bomb
  In order to intensify extortion

  Scenario: Confirmation button exists
    Given I login as "villain"
    And I boot the bomb
    When I use 1234 on the bomb
    Then I should see a "confirm" button

  Scenario: Bailing on confirmation should not activate the bomb
    Given I login as "villain"
    And I boot the bomb
    And I use 1234 on the bomb
    When I cancel the activation sequence
    Then I should see the status of the bomb is "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Activate Bomb: Default Success
    Given I login as "villain"
    And I boot the bomb
    And I use 1234 on the bomb
    When I confirm the activation sequence
    Then I should see the status of the bomb is "Active"
    And I should see the remaining defusal attempts is 3
    And I should see a bomb timer

  Scenario: Activate Bomb: Default Failure
    Given I login as "villain"
    And I boot the bomb
    When I use 666 on the bomb
    Then I should see "Invalid Activation Code"
    Then I should see the status of the bomb is "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Validate Activation Code is Numeric
    Given I login as "villain"
    And I boot the bomb
    When I use "STAHP" on the bomb
    Then I should see "Activation codes must be numeric"
    And I should see the status of the bomb is "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Activate Bomb: Positive Custom Success 
    Given I login as "villain"
    And I enter activation code 666
    And I boot the bomb
    And I use 666 on the bomb
    When I confirm the activation sequence
    Then I should see the status of the bomb is "Active"
    And I should see the remaining defusal attempts is 3
    And I should see a bomb timer

  Scenario: Activate Bomb: Negative Custom Success 
    Given I login as "villain"
    And I enter activation code 666
    And I boot the bomb
    And I use 1234 on the bomb
    Then I should see "Invalid Activation Code"
    And I should see the status of the bomb is "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
