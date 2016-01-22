Feature: Anonymous and logged in cart separation
  In order to purchase items from a page
  As an online shopper
  I want the ability to login and save a cart or shop anonymously

  Scenario: Anonymous user adds item and logs in to previous session
    Given an anonymous user adds an item to the cart
    When the user logs in to an authenticated session
    And the authenticated session cart has previously added items in it
    Then the cart should display items from the authenticated session

  Scenario: Anonymous user adds item an logs in to new session
    Given an anonymous user adds an item to the cart
    When the user logs in to an authenticated session
    And the authenticated session cart has no items in it
    Then the cart should display items from the unauthenticated session

  Scenario: Anonymous authenticates with no items, adds item and logs out
    Given an anonymous has no items in the cart
    When the user logs in to an authenticated session
    And adds an item to the cart and logs out again
    Then the cart should display no items
