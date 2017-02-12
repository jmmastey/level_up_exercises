Feature: activate the bomb

  Background:
    Given I booted the bomb
    And the bomb is not activated

  Scenario: activate the bomb with correct activation code
    When I try to activate the bomb using the code "1234"
    Then I should see the bomb is "activated"
    And the bomb timer is counting down
    And the button changed to "Deactivate"

  Scenario: activate the bomb with incorrect activation code
    When I try to activate the bomb using the code "4321"
    Then I should see the bomb is "not activated"
    And I should see alert message "Activation code does not match"
    And the "Activate" button should remains on the page
