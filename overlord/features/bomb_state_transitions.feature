Feature: bomb state transitions
  In order to visually represent changes in the state of the bomb
  As a crime overlord
  I want the bomb to notify me which state it is in by changing its physical appearance

  Background:
    Given I am on the bomb page

  Scenario: Initial bomb state is activation
    Then the bomb state should be activation

  Scenario: Submitting input at activation state switches bomb to deactivation state
    When I submit a valid code input
    Then the bomb state should be deactivation

  Scenario: Submitting input at deactivation state switches bomb to standby state
    When I submit a valid code input
    And I submit a valid code input
    Then the bomb state should be standby

  Scenario: Submitting input at standby state switches bomb to armed state
    When I submit a valid code input
    And I submit a valid code input
    And I submit a valid code input
    Then the bomb state should be armed
    And the bomb lid should be open