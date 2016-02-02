###Feature: Removing items from a shopping cart
* In order to buy only the merchandise I want
* I need to be able to remove items from my shopping cart

####Scenario: Removing an item from my cart (Happy)
* Given that I am on my shopping cart page
* And it contains one item
* And I want to remove the item
* When I click 'Remove Item'
* Then I should no longer see the item in my cart

####Scenario: Removing an item from my cart when there are multiple of the same item (Happy)
* Given that I am on my shopping cart page
* And it contains multiple of the same item
* And I want to remove one of the items
* When I click 'Remove Item'
* Then I should see the item's quantity decrease by one

####Scenario: Removing a non-existing item from my cart (Bad)
* Given that I have my shopping cart page open in two windows
* And the cart contains one item
* And I want to remove the item
* And I click 'Remove Item' in one of the windows
* When I click 'Remove Item' in the other window
* Then I should see an error message that my cart is already empty