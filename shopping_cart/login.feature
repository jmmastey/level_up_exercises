Feature: User login and authentication
  As an authenticated user my cart is remembered between sessions.
  Additionally, logging has the ability to transfer items into my user's cart
  from a previously anonymous session

  Background:
    Given there is a user account
    And there is 2 "WiiU" in the user's saved cart
    And there is 1 "PS4" in the user's saved cart
    And there is 1 "SNES" in the user's saved cart
    And the user is not logged in

  Scenario: Saved cart
    When the user logs in
    Then there should be 4 items in the cart

  Scenario: New item (merge cart)
    Given the user adds "xBox One" to cart
    When the user logs in
    Then there should be 5 items in the cart

  Scenario: Cart takes session quantities (more in session)
    Given the user adds 2 "SNES" to cart
    When the user logs in
    Then there should be 5 items in the cart

  Scenario: Cart takes session quantities (less in session)
    Given the user adds 1 "WiiU" to cart
    When the user logs in
    Then there should be 3 items in the cart

  Scenario: Cart emptied when user logs out
    Given the user is logged in
    And the cart has 4 items in it
    When the user logs out
    Then there should be 0 items in the cart
