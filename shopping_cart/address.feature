Feature: Edit my address
  In order to estimate shipping charges
  As the online shopper
  I want enter my shipping address

  Scenario: Enter or change address
  	Given I am on the shopping cart page
  	And the quantity is 0
  	And I click on the enter address button
  	When I enter my address in the fields
  	And I click submit
  	Then I see the new shipping address

 	Scenario: Get shipping estimate
  	Given I am on the shopping cart page
  	And the quantity > 1 
  	And I click on the enter address button
  	When I enter my address in the fields
  	And I click submit
  	Then I see the shipping estimate

  #sad 
  Scenario: Enter an invalid shipping address
  	Given I am on the cart page
  	And I click on the enter address button
  	When I enter an invalid zip code 00000
  	Then I see invalid zip code error message

  #bad
  Scenario: Enter and SQL injection code 
  	Given I am on the cart page
  	And I click on the enter address button
  	When I enter zip code SQL code ' OR '1'='1
  	Then I see invalid zip code error message