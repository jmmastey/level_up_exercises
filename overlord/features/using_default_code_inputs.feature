Feature: Using default code inputs
  In order to speed up the the time it takes to arm a bomb
  As a crime overlord
  I need to have preconfigured activation and deactivation bomb codes

  Background:
    Given I am on the bomb page

  Scenario: Submitting no input for activation causes default code to be used
    When I setup the bomb with the default activation code
    And I submit the default activation code
    Then the bomb state should be armed

  Scenario: Submitting no input for deactivation causes default code to be used
    When I arm the bomb with the default deactivation code
    And I submit the default deactivation code
    Then the bomb should be disarmed