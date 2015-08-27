Feature:  Add item to cart from Item page

Given I am on an item page
And I see 'In stock'
When I click on the 'add to cart' button
Then I should see 'item added to cart'

Given I am on an item page
When I see 'Not In stock'
Then I should not see the 'add to cart' button