###Feature: Navigating to item pages
* In order to make informed decisions about the merchandise I buy
* I need to be able to navigate to merchandise detail pages

####Scenario: Navigating to valid item page (Happy)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I want to review that item in more detail
* When I click on the item name
* Then the page title should be {{ item_name }}

####Scenario: Navigating to missing item page (Bad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I want to review that item in more detail
* And some reckless developer has deleted the item page
* When I click on the item name
* Then I should see a 404 page