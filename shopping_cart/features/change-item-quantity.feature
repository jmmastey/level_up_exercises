Feature: Change quantity of item in my cart
  As a fickle shopper
  I want to increase or decrease the quantity of each type of item in my cart
  So I can purchase the proper quantity of items

# Happy paths: :^D

Scenario: Increase quantity of available item
  Given I have 1 of an item in my cart
  And there are 5 available items
  When I increase the quantity of the item to 3
  Then my cart contains 3 of the item

Scenario: Decrease quantity of item by fewer than found in cart
  Given I have 3 of an item in my cart
  When I decrease the quantity of the item to 1
  Then my cart contains 1 of the item

Scenario: Decrease quantity of item by as many as found in cart
  Given I have 5 of an item in my cart
  When I decrease the quantity of the item to 0
  Then my cart does not show the item

Scenario: Decrease quantity of item by more than found in cart
  Given I have 2 of an item in my cart
  When I decrease the quantity of the item to -3
  Then my cart does not show the item

# Sad paths: ;^(

Scenario: Increase quantity of item beyond item availability
  Given I have 4 of an item in my cart
  And there are 6 of the item available
  When I increase the quantity of the item to 9
  Then I see an insufficient availability dialog for the item

Scenario: Increase quantity of available item not found in cart
  Given an item is not in my cart
  And there are 4 of the item is available
  When I increase the quantity of the item to 2
  Then my cart has 2 of the item

# Bad paths: >:^(

Scenario: Increase quantity of invalid item
  Given I edit the cart item page to make an item ID invalid
  When I change the quantity of the item to 3
  Then I see a generic error warning page
  And a link to return to the itemized cart page

Scenario: Change quantity to invalid value
  Given I edit the cart item page to make an item ID invalid
  When I change the quantity of the item to an invalid value
  Then I see a generic error warning page
  And a link to return to the itemized cart page
