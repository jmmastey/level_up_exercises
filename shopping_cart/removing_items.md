
<!-- * I should be able to add, remove, and change quantities on items in my cart. -->
<!-- * I should be able to get back to item pages from the cart by clicking on individual cart item lines. -->
<!-- * I should be able to put in my address information to get shipping estimates. -->
<!-- * I should be able to add coupons, which are hopefully NOT expired. -->
<!-- * Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session) -->
<!-- * Pay attention to cases such as adding another item of the same SKU as others in my cart. -->


###Feature: Removing items from a shopping cart
  In order to buy only the merchandise I want
  I need to be able to remove items from my shopping cart


####Scenario: Removing an item from my cart (Happy)
  Given that I am on my shopping cart page
  And it contains one item
  And I want to remove the item
  When I click 'Remove Item'
  Then I should no longer see the item in my cart

  Given that I am on my shopping cart page
  And it contains multiple of the same item
  And I want to remove one of the items
  When I click 'Remove Item'
  Then I should see the item's quantity decrease by one


####Scenario: Removing a non-existing item from my cart (Bad)
  Given that I have my shopping cart page open in two windows
  And the cart contains one item
  And I want to remove the item
  And I click 'Remove Item' in one of the windows
  When I click 'Remove Item' in the other window
  Then I should see an error message that my cart is already empty