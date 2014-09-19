Feature: Deactivation
  As a super-villain, hero, officer, bystander, or interested party
  I want to deactivate the bomb
  In order to survive

  Background:
    Given the bomb is booted with default codes
    And the code 1234 was entered
    And the code 0400 was entered

  @javascript
  Scenario: Deactivating a bomb with a valid code
    When I enter the code 0000
    Then the bomb should be inactive

  @javascript
  Scenario: Deactivating the bomb with an invalid code
    When I enter the code 5678
    Then I should see the message "INVALID CODE"

  @javascript
  Scenario: Deactivating the bomb with an invalid code and 1 remaining attempt
    Given 2 failed attempts have been made to disarm the bomb
    When I enter the code 5678
    Then the bomb should explode
