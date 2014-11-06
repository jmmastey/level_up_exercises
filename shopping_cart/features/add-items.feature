Feature: Add items to cart
  As a shopper
  I want to add items to my cart
  So I can purchase them

# Happy paths :^D
Scenario: Add 1 available item to cart
  Given I am on an item page for an item with 5 available
  And I have 0 of the item in my cart
  When I add the item to my cart
  Then my cart now has 1 of the item

Scenario: Add multiple of an available item to cart
  Given I am on an item page for an item with 5 available
  And I have 0 of the item in my cart
  When I add 4 of the item to my cart
  Then my cart now has 4 of the item

Scenario: Add multiple of available items to cart containing the item
  Given I am on an item page for an item with 5 available
  And my cart contains 3 of the item 
  When I add 4 of the item to my cart
  Then my cart contains 7 of the item

# Sad paths: :^(

Scenario: Add out-of-stock item to cart
  Given I am on an item page for an out-of-stock item
  And I have 0 of the item in my cart
  When I add 1 of the item to my cart
  Then I see an out-of-stock warning for the item
  And my cart contains 1 of the item
  And I see expected shipment date for the item

Scenario: Add items beyond available quantity
  Given I am on an item page for an item with 3 available
  And I have 0 of the item in my cart
  When I add 4 of the item to my cart
  Then I see an insufficient availability dialog for the item

Scenario: Add discontinued item to my cart
  Given I am on an item page for a discontinued item
  When I add the item to my cart
  Then I see a discontinued item warning for the item
  And my cart does not show the item

Scenario: Add invalid/missing SKU to cart
  Given I edit an item page to make the item ID invalid
  And I have an empty cart
  When I add the item to my cart
  Then I see generic error warning page
  And I see a link returning me to the most recently visited item page
  And my cart is empty

Scenario: Add negative quantity to my cart
  Given I edit an item page to make the quantity be -2
  And I have 3 of the item in my cart
  When I add the item to my cart
  Then I see a generic error warning page
  And I see a link returning me to the item page
  And my cart has 3 of the item

# Bad paths: >:^(

