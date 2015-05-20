Feature: add/remove items from shopping cart

  In order to create an order with the desired items
  As the customer
  I should add and remove items from my shopping cart

  Scenario: add an item to the shopping cart
    Given I am on the JellyBelly item page
    When I click Add Item button
    Then I see a message indicating 1 bag of JellyBelly candy has been added to the cart

  Scenario: add a negative number of items to the shopping cart
    Given I am on the JellyBelly item page
    When I enter -5 in the Quantity field
    And I click Add Item
    Then I see an error message indicating only positive integers quantities can be added to the cart

  Scenario: remove an item from the shopping cart
    Given I am on the cart page
    When I click the Remove Item button for the fish figurine item (quantity 3)
    Then I see a message indicating all 3 fish figurine items were removed
    And The number of items in the cart decreased by 3

  Scenario: decrement an item quantity from shopping cart
    Given I am on the cart page
    When I click the Update Quantity button for the garden hose
    And I decrease the quantity by 1 and click Update
    Then I see the quantity of garden hoses has been decremented by 1

  Scenario: decrement an item quantity by a number greater than the current count of the item
    Given I am on the cart page
    When I click the Update Quantity button for the garden hose
    And I decrease the quantity by 5 and click Update
    Then I see an error indicating that there are only 3 garden hoses currently in the cart

