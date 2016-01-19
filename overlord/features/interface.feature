Feature: Interface
  In order to toggle the activation state of the bomb
  As the overlord
  I want to enter a code into a text field on a web page

  Scenario: A text field for activation code exists
    Given an interface
    Then I have the ability to enter an activation code

  Scenario: Activate an inactive bomb
    Given I have entered the correct activation code into a text field
    And the bomb's active state is false
    When I submit the form
    Then the bomb active state should become true

  Scenario: Activating an active bomb does nothing
    Given I have entered the correct activation code into a text field
    And the bomb's active state is true
    When I submit the form
    Then nothing should happen

  Scenario: Deactivate the bomb with correct code
    Given I have entered the correct deactivation code into a text field
    And the bomb's active state is true
    When I submit the form
    Then the bomb state should become inactive

  Scenario: Deactivate bomb with correct code
    Given I have entered the correct deactivation code into a text field
    And the bomb's active state is true
    When I submit the form
    Then the bomb active state should become false

  Scenario: Entering deactivation code too many times results in detonation
    Given I have entered the incorrect deactivation code 3 times
    And the bomb's active state is true
    Then the bomb should detonate

  Scenario: Bomb is detonated, so the interface no longer works
    Given the bomb has been detonated
    Then the interface should no longer respond to user input

  Scenario: Interface displays active state true when it is true
    Given the bomb's active state is true
    Then the interface should display BOMB ACTIVE

  Scenario: Interface displays active state false when it is false
    Given the bomb's active state is false
    Then the interface should display BOMB DEACTIVATED