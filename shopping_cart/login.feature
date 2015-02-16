Feature: logging in

  Background:
    Given I am on the cart page
    And the cart is empty
    And I am not logged in

  Scenario: logging in retrieves cart items
    Given my account has 3 items saved in the cart
    And the cart is empty
    And I login
    Then the cart has 3 items

  Scenario: saved cart items mix with current items
    Given my account has 3 items saved in the cart
    And the cart has 2 items in it, one of which is the same as a saved item
    And I login
    Then the cart has 4 distinct items in it
    And the cart has a total of 5 items

  Scenario: logging in saves current items
    Given the cart has 2 items in it
    And I login
    And I logout/clear browser cookies
    And I login
    Then the cart has 2 items in it
