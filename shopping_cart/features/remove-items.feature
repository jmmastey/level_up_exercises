Feature: Remove items from cart
  As a shopper
  I want to remove items from my cart
  Because I had second thoughts about purchasing them

  Happy:
    Remove item from cart and item no longer shows in cart
  Sad:
    Remove item which is not present in cart (e.g. from stale page)
  Bad:
    Remove improperly identified item (invalid/missing SKU)

# Happy: :^D

Scenario: Remove singular item from cart
  Given I have 1 of an item in my cart
  When I remove the item from my cart
  Then my cart does not show the item

Scenario: Remove multiple of item from cart
  Given I have 4 of an item in my cart
  When I remove the item from my cart
  Then my cart does not show the item

# Sad: ;^D

Scenario: Remove an item from my cart that is not found in cart
  Given an item is in my cart
  And I duplicate my browser window
  And I remove the item from my cart
  When I remove the item from my cart in the duplicate window
  Then my cart does not show the item

Scenario: Remove invalid item from cart
  Given I edit the cart item page to make an item ID invalid
  When I remove the item from my cart
  Then my cart does not show the item

# Bad: >:^(

Scenario: Thwart deliberate malformed input
  Given I craft a cart request to remove an item with item ID of 1MB length
  When I submit the cart request
  Then I see a general error warning page
  And my cart is not changed
