Feature: add, remove, and change quantities on items in my cart
  
  Background:
    Given I am at the cart page
    And the cart quantity is 0
    And I am not logged in
    
  Scenario: Add item to cart
    Given I add the item to the cart
    Then I see the item within cart
    And the item quantity is 1

  Scenario: Add 2 same items
    Given I add the item to the cart
    And I add the same item to the cart
    Then I see 1 item within cart
    And the cart quantity is 2

  Scenario: Add 2 different items
    Given I add the item to the cart
    And I add another item to the cart
    Then I see 2 items within cart
    And the cart quantity is 2

  Scenario: Add item with quantity
    Given I add the item to the cart
    And I fill in "quantity" with "2"
    Then the cart quantity is 2

  Scenario: remove item with quantity 0
    Given I add the item to the cart
    And I fill in "quantity" with "0"
    Then I do not see the item within cart
    And the cart quantity is 0

  Scenario: remove item with button
    Given I add the item to the cart
    And I click "Remove" within item line
    Then I do not see the item within cart
    And the cart quantity is 0

  Scenario: logging in retrieves cart
    Given my account has a saved cart with quantity 5
    And I add the item to the cart
    And I login
    Then the cart quantity is 6

  Scenario: logging in saves existing cart
    Given I add the item to the cart
    And I login
    And I logout
    And I clear cookies
    And I login
    Then the cart quantity is 1

  Scenario: adding invalid item
    Given I add an invalid item to the cart
    Then I see "Error: Invalid Item"

  Scenario: adding invalid quantity
    Given I add an item to the cart
    And I fill in "quantity" with "-1"
    Then I see "Error: Invalid Quantity"

  Scenario: discontinued items
    Given I add the item to the cart
    And the quantity available is 0
    And the date available is empty
    Then I see "Error: Item Not Available"

  Scenario: backordered items
    Given I add the item to the cart
    And the quantity available is 0
    And the date available exists
    Then I see "Error: Item On Backorder"
