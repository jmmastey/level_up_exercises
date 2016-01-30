
<!-- * I should be able to add, remove, and change quantities on items in my cart. -->
<!-- * I should be able to get back to item pages from the cart by clicking on individual cart item lines. -->
<!-- * I should be able to put in my address information to get shipping estimates. -->
<!-- * I should be able to add coupons, which are hopefully NOT expired. -->
<!-- * Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session) -->
<!-- * Pay attention to cases such as adding another item of the same SKU as others in my cart. -->


###Feature: Navigating to item pages
  In order to make informed decisions about the merchandise I buy
  I need to be able to navigate to merchandise detail pages


####Scenario: Navigating to item pages (Happy)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I want to review that item in more detail
  When I click on the item name
  Then the page title should be {{ item_name }}


####Scenario: Navigating to item pages (Bad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I want to review that item in more detail
  And some reckless developer has deleted the item page
  When I click on the item name
  Then I should see a 404 page

