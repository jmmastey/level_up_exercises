Feature: Remove items from cart
  As a shopper
  I want to be able to remove items from my cart

# SO HAPPY

Scenario: Remove singular item from cart
  Given I have 1 of an item in my cart
  When I remove the item from my cart
  Then my cart does not show the item

Scenario: Remove multiple of item from cart
  Given I have 4 of an item in my cart
  When I remove the item from my cart
  Then my cart does not show the item

# SO SAD

Scenario: Remove an item from my cart that is not found in cart
  Given an item is in my cart
  And I duplicate my browser window
  And I remove the item from my cart
  When I remove the item from my cart in the duplicate window
  Then my cart does not show the item

# SO BAD
