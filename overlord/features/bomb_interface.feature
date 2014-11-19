Feature: View the bomb interface

  Scenario: Booting the bomb interface
    When I go to the bomb interface
    Then I should see a code entry box
    And the activation state of the bomb

  Scenario: Visiting the bomb interface for the first time
    Given it is my first time visiting the bomb interface
    When I go to the bomb interface
    Then I should see the activation state as de-activated
