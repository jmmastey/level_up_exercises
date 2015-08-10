Feature: Add, Remove, Change quantities in a shopping cart

Given I am on the shopping cart page
When I have at least one item in my cart
Then I should see 'Go to checkout'

Given I am on the shopping cart page
When I have no items in my cart
Then I should not see 'Go to checkout'

Given I am on the shopping cart page
And I have at least one item in my cart
When I click on an item in the cart
Then I should go to the item page

Given I am on the shopping cart page
And I have at least one item in my cart
When I click on 'change quantities'
And I click on '+'
Then I should see the item count increased

Given I am on the shopping cart page
And I have at least one item in my cart
When I click on 'change quantities'
And I click on '-'
Then I should see the item count decreased

Given I am on the shopping cart page
And I have at least one item in my cart
When I click on 'delete item'
Then I should see the item removed from the cart

Given I am on the shopping cart page
And I have items in my shopping cart
And I am not logged in
When I log in
Then I should still see those items in my cart

Given I am on the shopping cart page
And I have 1 item in my shopping cart
And I am not logged in
When I log in
And I have 2 items in my logged in cart
Then I should see 3 items in my cart

Given I am on an item page
And I have that item in my cart
When I click on the 'add to cart' button
Then I should see that item count increase by 1.