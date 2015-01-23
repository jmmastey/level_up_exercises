Feature: Bomb
  In order to activate bomb
  As a super villain
  I want to enter an activation code and deactivation code

  Background: A bomb exists
    Given a bomb

  Scenario: Bomb is booted
    Given I am looking at the page bomb
    Then I should see "Inactive" with id of textarea "#bomb_status"

  Scenario: Bomb is booted with no activation code configured
    Given I am looking at the page bomb
    And "#bomb_status" says "Inactive"
    And "activation_code" is not configured
    When I enter right "activation_code"
    Then I should see "Active" within "#bomb_status"

  Scenario: Bomb is booted with activation code configured
    Given I am looking at the page bomb
    And "activation_code" is configured to "2345"
    Then "activation_code" should contain "2345"
    Then I should see "Inactive" within "#bomb_status"