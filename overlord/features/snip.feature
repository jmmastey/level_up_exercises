
Feature: Snip wires to stop a bomb
  As any user or villian
  I want to physically disable a bomb
  
  Scenario: I want to cut the bomb wires 
    Given A bomb in any state
    When I click the scissors icon
    Then the bomb is deactivated
    And I see the bomb deactivated message



