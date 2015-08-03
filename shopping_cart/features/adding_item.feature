Feature: Adding items to the cart
  In order to failitate grouping all the items together before I checkout
  As an online shopper
  I want a place to keep items together to so they are remembered at checkout

  Background:
    Given I have an empty cart

  Scenario: Adding an item to an empty cart
    When I add an item to the cart
    Then the cart should have that item with quantity 1

  Scenario: Adding a different item to a non empty cart
    When I add an item to the cart
    And I add a different item to the cart
    Then the cart should have 2 items each with quantity 1

  Scenario: Adding same item to cart
    When I add an item to the cart
    And I add that same item to the cart again
    Then the cart should have 1 item with quantity 2

  Scenario: Merging old and new cart session items
    And I am logged out
    And I have an old cart session
    When I add an item to the cart
    And I login to the old cart session
    Then I should recieve a merged cart notification
    And the cart should have merged the old a new cart items

  Scenario: Adding an out of stock item
    When I add an item that is out of stock
    Then I should recieve a warning notification
    And the cart should be empty
