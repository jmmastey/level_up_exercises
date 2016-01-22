Feature: Shopping cart item info
  In order to view correct item data
  As an online shopper
  I want the ability to view information about items in my cart

  Scenario: Ability to navigate to item page from cart
    Given the cart has an item in it
    When a user clicks the item row
    Then the page should navigate to that item's description page

  Scenario: Cart displays information about each item
    Given the cart contains one or more items
    When a user views the cart details page
    Then the user should see a thumbnail of the item
    And item title
    And item description
    And item price

  Scenario: Cart displays price total
    Given the cart contains one or more items
    When a user views the cart details page
    Then the user should see a price total for items
