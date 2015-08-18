Feature: Removing items to the cart
  In order to get rid of items I no longer want
  As an online shopper
  I need to be able to remove items from my cart

  Scenario: Removing the only item from the cart
    Given I have 1 item in my shopping cart
    When I remove the first item
    Then the cart should be empty

  Scenario: Removing one of many items from the cart
    Given I have 3 items in my shopping cart
    When I remove the second item
    Then the cart should be have 2 items
