Feature: Use the online shopping cart
  In order to shop
  As the online shopper
  I want to add, remove, change, and see details on items in my cart

  Scenario: Add items to my cart
    Given I am on an item page
    When I click "add" 
    Then I see the quantity increase by 1

  Scenario: Remove items from my cart
    Given I am on the shopping cart page
    And my cart quantity is > 0
    When I click the "remove" button
    Then I see the quantity decrease by 1

  Scenario: Change quantity of items in my cart
    Given I am on the shopping cart page
    And my cart quantity is > 0
    When I click the "change" quantity button
    And I enter the new quantity in the input field
    Then I see the quantity change to the new quantity

  Scenario: Navigate from cart to item page
    Given I am on the cart page
    And my cart quantity > 0
    When I click the item description link
    Then I see the item description page


