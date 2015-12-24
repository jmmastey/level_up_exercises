Feature: Log-in
  In order to log-in
  As a user
  I want to log-in
  So that I can prevent unauthorized access

  Scenario: Log-in as a user
    Given I am on the home page
    And I am a registered user
    When I fill in and submit my username and password
    Then I should be logged in

  Scenario: Prevent logging in if not registered
    Given I am on the home page
    And I am not a registered user
    When I fill in and submit my username and password
    Then I should not be logged in
    And the page should show the error message

  Scenario: Logging in after adding items to cart
    Given I already have items in my shopping cart but have not logged in
    When I log in
    Then I should still have those items in my shopping cart

  Scenario: Seeing shopping cart history from a previous log-in
    Given I had items added from a prior unfinished checkout
    When I log-in
    Then I should still have those items in my shopping cart
