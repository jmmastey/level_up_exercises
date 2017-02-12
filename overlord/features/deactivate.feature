Feature: Deactivate the bomb
  As a super villain
  I want to be able to deactivate the bomb
  So I can blow stuff up at a later date

  Scenario: Enter correct deactivation code
    Given the bomb has been booted with default codes
    And the bomb has been activated
    When I submit the correct deactivation code
    Then I should see "Bomb is currently: INACTIVE"

  Scenario: Enter incorrect deactivation code once
    Given the bomb has been booted with default codes
    And the bomb has been activated
    When I submit an incorrect deactivation code 1 time
    Then I should see "Incorrect code. You have 2 tries remaining."

  Scenario: Enter incorrect deactivation code twice
    Given the bomb has been booted with default codes
    And the bomb has been activated
    When I submit an incorrect deactivation code 2 times
    Then I should see "Incorrect code. You have 1 try remaining."

  Scenario: Deactivate bomb after submitting incorrect deactivation code
    Given the bomb has been booted with default codes
    And the bomb has been activated
    When I submit an incorrect deactivation code 1 time
    And I submit the correct deactivation code
    Then I should see "Bomb is currently: INACTIVE"
