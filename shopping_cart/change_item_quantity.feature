Feature: Change item quantity in the cart
  As a shopper
  I want to be able to change 
  the number of items in my cart

#	SO HAPPY

Scenario: Increase quantity of item in cart
  Given I am on shopping cart page
  And I have 2 of an item in my cart
  When I increase the quantity by 3
  Then my cart now has 5 of this item

Scenario: Decrease quantity of item in cart by less than current quantity
  Given I am on shopping cart page
  And I have 5 of an item in my cart
  When I decrease the quantity by 3
  Then my cart now has 2 of this item

Scenario: Decrease quantity of item in cart by same as current quantity
  Given I am on shopping cart page
  And I have 5 of an item in my cart
  When I decrease the quantity by 5
  Then my cart now has 0 of this item

  Scenario: Decrease quantity of item in cart by more than current quantity
  Given I am on shopping cart page
  And I have 5 of an item in my cart
  When I decrease the quantity by 7
  Then my cart now has 0 of this item

# SO SAD

Scenario: Increase quantity of item in cart to more than available
  Given I am on shopping cart page
  And I have 5 of an item in my cart
  And there are only 5 of the item available
  When I increase the quantity by 2
  Then an insufficient avilable items notice comes up

# SO BAD

Scenario: Change quantity to invalid value
  Given I am on shopping cart page
  And I have 5 of an item in my cart
  When I change the quantity of the item to an invalid value
  Then I see a generic error warning page
  And a link to return to the cart page