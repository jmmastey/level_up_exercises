Feature: The bomb has a big red button!  It... confirms activation.
  In order to justify having a big red button on my bomb
  As a supervillain
  I want entry of the activation code to be confirmed with a big red button

  Scenario: Entering the activation code requires confirmation
    Given an inactive bomb with activation code "1234"
    When I submit code "1234"
    Then I need to confirm activation
    And I should see "BigRedButton"
    And "BigRedButton" is "big"
    And "BigRedButton" is "red"
