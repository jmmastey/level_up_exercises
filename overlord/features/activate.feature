Feature: I activate the bomb

  Background:
    When I boot the bomb "/boot"

  @javascript
  Scenario: activate the bomb with correct activate code
    Then I enter activation code "1234"
    When I click "Activate"
    Then I should see the bomb state : "Activated"
    And the bomb timer is counting down
    And I should see "Deactivate" button

  @javascript
  Scenario: activate the bomb with incorrect activate code
    Then I enter activation code "4321"
    When I click "Activate"
    Then I should see the bomb state : "Not Activate"
    And I should see "Activate" button
    And I should see alert message "Activation code does not match"
