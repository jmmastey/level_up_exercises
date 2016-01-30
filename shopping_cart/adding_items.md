###Feature: Adding items to a shopping cart
  In order to buy the merchandise I want
  I need to be able to add items to my shopping cart

####Scenario: Adding an in-stock item to my cart (Happy)
  Given that I am on an item page
  And the item is in stock
  When I click 'Add to cart'
  Then I should see a confirmation message that the item was successfully added to my cart

####Scenario: Adding an in-stock item and viewing it in my cart (Happy)
  Given that I am on an item page
  And the item is in stock
  And I have NOT already added the item to my cart
  And I click 'Add to cart'
  When I visit the shopping cart page
  Then I should see my item listed

####Scenario: Adding another in-stock item and viewing it in my cart (Happy)
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

####Scenario: Adding an out-of-stock item to my cart and viewing my cart (Bad)
  Given that I am on an item page
  And the item is NOT in stock
  And I click 'Add to cart'
  When I visit the shopping cart page
  Then I should NOT see my item listed