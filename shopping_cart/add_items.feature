Feature: Add item to cart
  As a shopper
  I want to be able to add items to my cart
  So I can purchase them

# SO HAPPY

Scenario: Add single item to cart
  Given I am on an item page for an item with 10 available
  And I have 0 of this item in my cart
  When I add one of this item to my cart
  Then my cart now has 1 of this item

Scenario: Add multiple of an available item to cart
  Given I am on an item page for an item with 15 available
  And I have 0 of the item in my cart
  When I add 4 of the item to my cart
  Then my cart now has 4 of the item

Scenario: Add multiple of available items to cart containing the item
  Given I am on an item page for an item with 20 available
  And my cart contains 3 of the item 
  When I add 4 of the item to my cart
  Then my cart contains 7 of the item

# SO SAD

Scenario: Add out-of-stock item to cart
  Given I am on an item page for out-of-stock item
  And I have 0 of the item in my cart
  When I add 1 of the item to my cart
  Then I see an out-of-stock warning for the item
  And my cart contains 1 of the item

Scenario: Add items beyond available quantity
  Given I am on an item page for an item with 3 available
  And I have 0 of the item in my cart
  When I add 4 of the item to my cart
  Then I see a currently unavailable message

Scenario: Add discontinued item to my cart
  Given I am on an item page for a discontinued item
  When I add the item to my cart
  Then I see a discontinued item error

# SO BAD