
<!-- * I should be able to add, remove, and change quantities on items in my cart. -->
<!-- * I should be able to get back to item pages from the cart by clicking on individual cart item lines. -->
<!-- * I should be able to put in my address information to get shipping estimates. -->
<!-- * I should be able to add coupons, which are hopefully NOT expired. -->
<!-- * Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session) -->
<!-- * Pay attention to cases such as adding another item of the same SKU as others in my cart. -->
<!-- * Don't worry about product pages or checkout. -->


###Feature: Adding address information to get shipping estimates
  In order to make an informed decision about the merchandise I buy
  I need to be able to get shipping estimates

####Scenario: Adding my address to get a shipping estimate (Happy)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I enter my zip code
  And I select a shipping carrier
  When I click 'Estimate shipping costs'
  Then I should see a shipping estimate based on my location


####Scenario: Adding my address to get a shipping estimate (Sad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I do not enter my zip code
  And I select a shipping carrier
  When I click 'Estimate shipping costs'
  Then I should see an error message prompting me to enter my zip code

  Given that I am on my shopping cart page
  And I have an item in my cart
  And I enter my zip code
  And I do not select a shipping carrier
  When I click 'Estimate shipping costs'
  Then I should see an error message prompting me to select a carrier

  Given that I am on my shopping cart page
  And I have an item in my cart
  And I do not enter my zip code
  And I do not select a shipping carrier
  When I click 'Estimate shipping costs'
  Then I should see an error message prompting me to select a carrier and enter my zip code


####Scenario: Adding my address to get a shipping estimate (Bad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I enter an invalid zip code
  And I select a shipping carrier
  When I click 'Estimate shipping costs'
  Then I should see an error message prompting me to enter my zip code