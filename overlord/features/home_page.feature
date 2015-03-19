Feature: Using the bomb
  As a super villain
  I want to see the home page of the bomb app
  So I can operate the bomb

  Scenario: View bomb status
    Given The bomb has been booted
    When I visit the home page 
    Then I should see "Bomb is currently: INACTIVE"

  Scenario: View bomb control form
    Given The bomb has been booted
    When I visit the home page
    Then I should see an entry field
    And I should see a submit button

  Scenario: Enter incorrect activation code
    Given The bomb has been booted
    And The bomb has been configured with default codes
    When I submit an incorrect activation code
    Then I should see "Bomb is currently: INACTIVE"

  Scenario: Enter correct activation code
    Given The bomb has been booted
    And The bomb has been configured with default codes
    When I submit the correct activation code
    Then I should see "Bomb is currently: ARMED"

  Scenario: Enter correct activation code after bomb is activated
    Given The bomb has been booted
    And The bomb has been configured with default codes
    And The bomb has been activated
    When I submit the correct activation code
    Then I should see "Bomb is currently: ARMED"

  Scenario: Enter correct deactivation code
    Given The bomb has been booted
    And The bomb has been configured with default codes
    And The bomb has been activated
    When I submit the correct deactivation code
    Then I should see "Bomb is currently: INACTIVE"

  Scenario: Enter incorrect deactivation code once
    Given The bomb has been booted
    And The bomb has been configured with default codes
    And The bomb has been activated
    When I submit an incorrect deactivation code one time
    Then I should see "Incorrect code. You have 2 tries remaining."

  Scenario: Enter incorrect deactivation code twice
    Given The bomb has been booted
    And The bomb has been configured with default codes
    And The bomb has been activated
    When I submit an incorrect deactivation code two times
    Then I should see "Incorrect code. You have 1 try remaining."

  Scenario: Enter incorrect deactivation code thrice
    Given The bomb has been booted
    And The bomb has been configured with default codes
    And The bomb has been activated
    When I submit an incorrect deactivation code three times
    Then I should be on the boom page
    And I should see "Boom!"
