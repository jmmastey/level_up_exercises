###Feature: Changing quantity of shopping cart items
* In order to buy as much of the merchandise I want
* I need to be able to change the quantity of items my shopping cart

####Scenario: Increasing quantity (Happy)
* Given that I am on my shopping cart page
* And I have 3 items in my cart
* And I want to change the quantity of that item to 4
* And there are at least 4 items of that kind in stock
* And I click 'Change Quantity'
* And I enter 4
* When I click 'submit'
* Then I should see the quantity of items updated to 4

####Scenario: Reducing quantity (Happy)
* Given that I am on my shopping cart page
* And I have 3 items in my cart
* And I want to change the quantity of that item
* And I click 'Change Quantity'
* And I enter 2
* When I click 'submit'
* Then I should see the quantity of items updated to 2

####Scenario: Reducing quantity to zero (Happy)
* Given that I am on my shopping cart page
* And I have 3 items in my cart
* And I want to change the quantity of that item
* And I click 'Change Quantity'
* And I enter 0
* When I click 'submit'
* Then I should not see the item listed anymore

####Scenario: Attempting to change quantity without entering a new number (Sad)
* Given that I am on my shopping cart page
* And I have an item in my cart
* And I want to change the quantity of that item
* And I click 'Change Quantity'
* And I fail to enter any number
* When I click 'submit'
* Then I should see an error message that prompts me to enter a number

####Scenario: Attempting to change quantity to a non-number (Bad)
* Given that I am on my shopping cart page
* And I have 3 items in my cart
* And I want to change the quantity of that item
* And I click 'Change Quantity'
* And I enter a non-number (such as 'a')
* When I click 'submit'
* Then I should see an error message that prompts me to enter a number

####Scenario: Attempting to increase quantity when there is not enough stock (Bad)
* Given that I am on my shopping cart page
* And I have 3 items in my cart
* And I want to change the quantity of that item
* And I click 'Change Quantity'
* And there are only 4 items in stock
* And I enter 5
* When I click 'submit'
* Then I should see an error message that tells me there are only 4 items in stock
* Then I should not see my item quantity change
