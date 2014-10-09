Feature: cheaters cant trick the bomb

  As a villain
  I want the bomb to go off when I set it
  So that cheaters can't stop me from blowing stuff up

  Scenario: the bomb blows up on too many attempts
    Given I have already activated the bomb
    When I attempt to deactivate with the wrong code too many times
    Then The bomb should explode

  Scenario: the bomb cannot be used after exploding
    Given the bomb has already exploded
    And I am on the inactivated page
    Then The bomb should explode
