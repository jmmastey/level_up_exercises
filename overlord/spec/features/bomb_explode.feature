Feature: Explode the Bomb
  In order to be destructive or stupid
  As a super villain
  I want the bomb to explode

  Background:
    Given I have booted the bomb
    And I enter the right activation code

  @sad
  Scenario: The bomb explodes
    When I enter the wrong deactivation code three times
    Then the status indicator shows as detonated
    And the buttons do not work