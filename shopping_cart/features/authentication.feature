Feature: authentication

  As a customer
  I want my cart to remain unchanged when I authenticate
  So that I do not have to log in to shop

  Scenario: authenticate with items in cart
    Given my cart contains items
    And I am not authenticated
    When I login
    Then the items appear in my cart

  Scenario: log out with items in cart
    Given my cart contains items
    And I am authenticated
    When I login
    Then the items appear in my cart
