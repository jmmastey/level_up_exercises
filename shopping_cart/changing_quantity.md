
<!-- * I should be able to add, remove, and change quantities on items in my cart. -->
<!-- * I should be able to get back to item pages from the cart by clicking on individual cart item lines. -->
<!-- * I should be able to put in my address information to get shipping estimates. -->
<!-- * I should be able to add coupons, which are hopefully NOT expired. -->
<!-- * Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session) -->
<!-- * Pay attention to cases such as adding another item of the same SKU as others in my cart. -->


###Feature: Changing quantity of shopping cart items
  In order to buy as much of the merchandise I want
  I need to be able to change the quantity of items my shopping cart


####Scenario: Reducing quantity (Happy)
  Given that I am on my shopping cart page
  And I have 3 items in my cart
  And I want to change the quantity of that item
  And I click 'Change Quantity'
  When I enter 2
  Then I should see the quantity of items updated to 2

  Given that I am on my shopping cart page
  And I have 3 items in my cart
  And I want to change the quantity of that item
  And I click 'Change Quantity'
  When I enter 0
  Then I should not see the item listed anymore


####Scenario: Changing quantity (Sad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I want to change the quantity of that item
  And I click 'Change Quantity'
  And I fail to enter any number
  When I click 'submit'
  Then I should see an error message that prompts me to enter a number


####Scenario: Changing quantity (Bad)
  Given that I am on my shopping cart page
  And I have 3 items in my cart
  And I want to change the quantity of that item
  And I click 'Change Quantity'
  When I enter a non-number (such as 'a')
  Then I should see an error message that prompts me to enter a number

  Given that I am on my shopping cart page
  And I have 3 items in my cart
  And I want to change the quantity of that item
  And I click 'Change Quantity'
  And there are only 4 items in stock
  When I enter 5
  Then I should see an error message that tells me there are only 4 items in stock

  Given that I am on my shopping cart page
  And I have 3 items in my cart
  And I want to change the quantity of that item
  And I click 'Change Quantity'
  And there are only 4 items in stock
  When I enter 5
  Then I should not see my item quantity change



