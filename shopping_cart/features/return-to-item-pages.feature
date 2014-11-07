Feature: Return to item pages from cart items page
  As a forgetful shopper
  I would like to return to item product pages from the line items on the cart
  items page
  So I can remember what these things are that I'm buying

# Happy: :^D

Scenario: Click on line item in cart and return to item page
  Given I have an item in my cart
  And I navigate to the cart item page
  When I click on item name in the cart line item
  Then I see the item page

# Sad: ;^(

# Bad: >:^(

