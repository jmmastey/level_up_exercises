Feature: Log-out
  In order to log-out
  As a user
  I want to log-out
  So that I can prevent unauthorized access into my account

  Scenario: Log-out as a user
    Given I am logged in as a user
    When I choose to log out via the log out link
    Then I should be logged out

  Scenario: Logging out after adding items to cart
    Given I am logged in as a user
    And I already have items in my shopping cart
    When I choose to log out without emptying my shopping cart
    Then my added items should be auto-saved in my history for the next log-in
