Feature: Log-out
  In order to log-out
  As a user
  I want to log-out
  So that I can prevent unauthorized access into my account

  Scenario: Log-out as a user
    Given I am logged in as a user
    When I log out
    Then I should be logged out

  Scenario: Logging out after adding items to cart
    Given I am logged in as a user
    And I already have items in my shopping cart
    When I log out
    Then my shopping cart is empty
    When I log in
    Then my previously added items are in my history
