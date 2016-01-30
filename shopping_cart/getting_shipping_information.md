###Feature: Adding address information to get shipping estimates
* In order to make an informed decision about the merchandise I buy
* I need to be able to get shipping estimates

####Scenario: Adding my address to get a shipping estimate (Happy)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I enter my zip code
* And I select a shipping carrier
* When I click 'Estimate shipping costs'
* Then I should see a shipping estimate based on my location and carrier

####Scenario: Update shipping info when items are added (Happy)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I enter my zip code
* And I select a shipping carrier
* And I click 'Estimate shipping costs'
* And I see a shipping estimate
* When I change the quantity of items in my cart
* Then I should see my shipping estimate update automatically

####Scenario: Requesting shipping estimate without zip code (Sad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I do not enter my zip code
* And I select a shipping carrier
* When I click 'Estimate shipping costs'
* Then I should see an error message prompting me to enter my zip code

####Scenario: Requesting shipping estimate without preferred carrier (Sad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I enter my zip code
* And I do not select a shipping carrier
* When I click 'Estimate shipping costs'
* Then I should see an error message prompting me to select a carrier

####Scenario: Requesting shipping estimate without preferred carrier or zip code (Sad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I do not enter my zip code
* And I do not select a shipping carrier
* When I click 'Estimate shipping costs'
* Then I should see an error message prompting me to select a carrier and enter my zip code

####Scenario: Requesting shipping estimate with invalid zip code (Bad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I enter an invalid zip code
* And I select a shipping carrier
* When I click 'Estimate shipping costs'
* Then I should see an error message prompting me to enter my zip code

####Scenario: Requesting shipping estimate with ineligible carrier (Bad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I enter my zip code
* And I select a shipping carrier who does not ship to my zip code
* When I click 'Estimate shipping costs'
* Then I should see an error message prompting me to select a different carrier


####Scenario: Invalidating shipping info when items are added (Bad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I enter my zip code
* And I select a shipping carrier
* And I click 'Estimate shipping costs'
* And I see a shipping estimate
* When I add an item to my cart that is ineligible to be shipped by my carrier
* Then I should see my shipping estimate reset automatically
