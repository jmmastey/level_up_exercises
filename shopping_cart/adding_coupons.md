###Feature: Adding coupons
  In order to the best deals on merchandise that I want to buy
  I need to be able to apply coupon codes to my order

####Scenario: Adding a valid coupon code for one item (Happy)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I have a coupon code
  And it is not expired
  And it is applicable to the item in my cart
  And I enter the coupon code
  When I click 'Apply discount'
  Then I should see my order total reduced by the value of the coupon

####Scenario: Adding a valid coupon code for multiple items (Happy)
  Given that I am on my shopping cart page
  And I have two items in my cart
  And I have a coupon code
  And it is not expired
  And it is applicable to both items in my cart
  And I enter the coupon code
  When I click 'Apply discount'
  Then I should see my order total reduced by the value of the coupon

####Scenario: Adding a valid coupon code for one item in a cart with multiple items (Happy)
  Given that I am on my shopping cart page
  And I have two items in my cart
  And I have a coupon code
  And it is not expired
  And it is applicable to one of the items in my cart
  And I enter the coupon code
  When I click 'Apply discount'
  Then I should see the price of the eligible item reduced by  by the value of the coupon

####Scenario: Attempting to apply discount without coupon code (Sad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I have a coupon code
  And it is not expired
  And it is applicable to the item in my cart
  And I enter no coupon code
  When I click 'Apply discount'
  Then I should see an error message that prompts me to enter a coupon

####Scenario: Adding an expired coupon code (Bad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I have a coupon code
  And it is expired
  And it is applicable to the item in my cart
  And I enter the coupon code
  When I click 'Apply discount'
  Then I should see an error message that informs me the coupon is expired

####Scenario: Adding a coupon code for an ineligible item (Bad)
  Given that I am on my shopping cart page
  And I have an item in my cart
  And I have a coupon code
  And it is not expired
  And it is not applicable to the item in my cart
  And I enter the coupon code
  When I click 'Apply discount'
  Then I should see an error message that informs my item is ineligible for discount