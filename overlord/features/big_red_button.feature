Feature: The bomb has a big red button!  It... confirms activation.
  In order to justify having a big red button on my bomb
  As a supervillain
  I want entry of the activation code to be confirmed by pushing a button

  Scenario: Entering the activation code requires confirmation
    Given an inactive bomb with activation code "1234"
    When I fill in "code" with "1234"
    Then I need to confirm activation

  Scenario: The button vanishes if not clicked within 15 seconds
    Given a bomb waiting for confirmation of activation
    When I wait 16 seconds
    Then I should not see "Big Red Button"

  Scenario: The button allows confirmation for 15 seconds after code entry
    Given a bomb waiting for confirmation of activation
    When I wait 14 seconds
    Then I should see "Big Red Button"