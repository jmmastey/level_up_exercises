Feature: Deactivation
  As a super-villain, hero, officer, bystander, or interested party
  I want to deactivate the bomb
  In order to survive

  Background:
    Given the bomb is booted with default codes
    And the bomb is active

  Scenario: Deactivating a bomb with a valid code
    When I enter the code 0000
    And click Enter
    Then the bomb should be inactive

  Scenario: Deactivating the bomb with an invalid code
    When I enter the code 5678
    And click Enter
    Then the number of remaining disarm attempts should be 2

  Scenario: Deactivating the bomb with an invalid code and 1 remaining attempt
    Given 2 failed attempts have been made to disarm the bomb
    When I enter the code 5678
    And click Enter
    Then the bomb should explode
