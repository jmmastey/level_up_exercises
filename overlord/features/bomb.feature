Feature: Bomb
  In order to activate bomb
  As a super villain
  I want to enter an activation code and deactivation code

  Scenario: Bomb is booted
    Given I am on the bomb page
    Then I should see "Inactive" with id of textarea "#bomb_status"

  Scenario: Bomb is booted with no activation code configured
    Given I am on the bomb page
    And "#bomb_status" says "Inactive"
    And "activation_code" is not configured
    When I enter right "activation_code"
    Then I should see "Active" within "#bomb_status"

  Scenario: Bomb is booted with activation code configured
    Given I am on the bomb page
    And "activation_code" is configured to "2345"
    Then "activation_code" should contain "2345"
    Then I should see "Inactive" within "#bomb_status"