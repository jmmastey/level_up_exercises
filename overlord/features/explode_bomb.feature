Feature: Exploding the bomb
  As a User
  I want to explode the bomb
  In order to see what happens

  Background:
    Given I have entered the activation and deactivation codes
    And the bomb is active

  Scenario: The bomb explodes if I enter the wrong deactivation code three times
    Given I have a bomb with two incorrect attempts
    When I enter the incorrect deactivation code
    Then the bomb should be exploded

  Scenario: The bomb should deactivate if I enter the wrong deactivation code twice followed by the correct deactivation code
    Given I have a bomb with two incorrect attempts
    When I enter my correct deactivation code
    Then the bomb should be deactivated

  Scenario: The bomb should be disabled after it explodes
    Given the bomb has exploded
    Then the Enter Code button should not work
