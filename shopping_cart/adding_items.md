
<!-- * I should be able to add, remove, and change quantities on items in my cart. -->
<!-- * I should be able to get back to item pages from the cart by clicking on individual cart item lines. -->
<!-- * I should be able to put in my address information to get shipping estimates. -->
<!-- * I should be able to add coupons, which are hopefully NOT expired. -->
<!-- * Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session) -->
<!-- * Pay attention to cases such as adding another item of the same SKU as others in my cart. -->
<!-- * Don't worry about product pages or checkout. -->


###Feature: Adding items to a shopping cart
  In order to buy the merchandise I want
  I need to be able to add items to my shopping cart

####Scenario: Adding an in-stock item to my cart (Happy)
  Given that I am on an item page
  And the item is in stock
  When I click 'Add to cart'
  Then I should see a confirmation message that the item was successfully added to my cart

  Given that I am on an item page
  And the item is in stock
  And I have NOT already added the item to my cart
  And I click 'Add to cart'
  When I visit the shopping cart page
  Then I should see my item listed

  Given that I am on an item page
  And the item is in stock
  And I have already added the item to my cart n times
  And I click 'Add to cart'
  When I visit the shopping cart page
  Then I should see my item listed with a quantity of n + 1


####Scenario: Adding an out-of-stock item to my cart (Bad)
  Given that I am on an item page
  And the item is NOT in stock
  When I click 'Add to cart'
  Then I should see an error message informing me that the item is out of stock

  Given that I am on an item page
  And the item is NOT in stock
  And I click 'Add to cart'
  When I visit the shopping cart page
  Then I should NOT see my item listed