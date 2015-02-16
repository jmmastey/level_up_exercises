Feature: Add, remove, and update items in the cart as well as navigate to the item page

  Background:
    Given I am on the cart page
    And the cart is empty
    And I am not logged in

  Scenario: Add an item to the cart
    Given I add an item to the cart
    Then the item appeard in the cart
    And the cart has 1 item

  Scenario: Add 2 of the same item to the cart
    Given I add an item to the cart
    When I add that same item again
    Then the cart has one distinct item
    And the cart has 2 total items

  Scenario: Add 2 different items to the cart
    Given I add an item to the cart
    And I add another item to the cart
    Then The cart has 2 distinct items

  Scenario: Change the quantity of an item
    Given I add an item to the cart
    When I update the quantity of the item to 2
    And click update
    Then the cart has 1 distinct item
    And the cart has 2 total items

  Scenario: Remove item with button
    Given I add an item to the cart
    When I click the 'remove' button next to the item
    Then The item is removed
    And the cart is empty

  Scenario: Remove item by updating quantity
    Given I add an item to the cart
    When I update the quantity of the item to 0
    And click update
    Then the item is removed
    And the cart is empty

    Scenario: Navigate to item page by clicking name
      Given I add an item to the cart
      When I click on the item name
      Then I navigate to the item page

    Scenario: Navigate to item page by clicking picture
      Given I add an item to the cart
      When I click on the item image
      Then I navigate to the item page

    Scenario: Continue with checkout
      Given I add an item to the cart
      When I click the 'checkout' button
      Then I navigate to the checkout page

    Scenario: invalid item
      Given I add an invalid item to the cart
      Then I see "Error: Invalid item"

    Scenario: invalid quantity
      Given I add an item to the cart
      When I update the quantity of the item to -1
      And click update
      Then I see "Error: Invalid quantity"