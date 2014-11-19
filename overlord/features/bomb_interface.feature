Feature: View the bomb interface

  Scenario: Booting the bomb interface
    Given I am viewing the bomb interface
    Then I should see a code entry box
    And the activation state of the bomb
