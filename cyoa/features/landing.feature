Feature: Landing page
  In order to see weather information
  As a user
  I want to see the correct landing page

  Scenario: Unregistered landing
    Given I am not logged in
    When I navigate to the main URL
    Then I see weather information
    And I see a register now option
    And I see a login option

  Scenario: Logged in landing
    Given some registered users
    And I am logged in
    When I navigate to the main URL
    Then I see weather information
    And I see a logout option
    And I see a settings option