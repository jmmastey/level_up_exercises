Feature: Add coupon to my order
  In order to save money
  As the online shopper
  I want enter a coupon code

  Scenario: Enter a valid coupon code 
  	Given I am on the cart page
  	And the quantity is > 0
  	When I enter a coupon code
  	And the coupon code is not expired
  	Then I see the total price discounted

  #sad 
  Scenario: Enter an expired or invalide coupon code
  	Given I am on the cart page
  	And the quantity is > 0
  	When I enter a coupon code
  	And the coupon code is expired or invalid
  	Then I see no change in the total price

  #bad
  Scenario: Enter and SQL injection code 
  	Given I am on the cart page
  	When I enter SQL code ' OR '1'='1
  thehen I see no change in the total price
