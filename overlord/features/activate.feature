Feature: Activate the bomb
  As a super villain
  I want to activate the bomb 
  So I can use it to blow stuff up

  Background:
    Given the bomb has been booted with default codes

  Scenario: View bomb control form
    When I visit the home page
    Then I should see an entry field
    And I should see a submit button

  Scenario: Enter incorrect activation code
    When I submit an incorrect activation code
    Then I should see "Bomb is currently: INACTIVE"

  Scenario: Enter correct activation code
    When I submit the correct activation code
    Then I should see "Bomb is currently: ARMED"

  Scenario: Enter correct activation code after bomb is activated
    Given the bomb has been activated
    When I submit the correct activation code
    Then I should see "Bomb is currently: ARMED"
