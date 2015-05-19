Feature: add/remove items from shopping cart

  In order to create an order with the desired items
  As the customer
  I should add and remove items from my shopping cart

  Scenario: add an item to the shopping cart
    Given I am on the item page
    When I click Add Item button
    Then I see a message indicating the item has been added to the cart

  Scenario: remove an item from the shopping cart
    Given I am on the cart page
    When I click the Remove Item button
    Then I see a message indicating the item was removed
    And The number of items in the cart decreased by the quantity of the removed item

  Scenario: decrement an item quantity from shopping cart
    Given I am on the cart page
    When I click the Update Quantity button for an item
    And I decrease the quantity by 1 and click Update
    Then I see the quantity has been decremented by 1

