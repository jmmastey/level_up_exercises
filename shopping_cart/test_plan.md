##Overview + Specs

This test plan is for a typical e-commerce shopping cart. They are written in rough/imperfect cucumber syntax.

###Requirements

- The shopping cart behaves a lot like every other cart you've seen on the internet. We're not shooting for the stars on this one.
- I should be able to add, remove, and change quantities on items in my cart.
- I should be able to get back to item pages from the cart by clicking on individual cart item lines.
- I should be able to put in my address information to get shipping estimates.
- I should be able to add coupons, which are hopefully not expired.
- Pay attention to cases such as logging in (if I have items in my cart as an anonymous user, but also have cart items from a previous authenticated session), or adding another item of the same SKU as others in my cart.
- Don't worry about product pages or checkout.

#[feature] Adjust quantities on items in my cart or delete them

(happy path)
Scenario: Delete item from cart on shopping cart page
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	When I click the "Delete" link
	Then I should have 0 items in my cart

(happy path)
Scenario: Change item quantity in cart on shopping cart page
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	When I fill in the item quantity for the first item with "3"
	And I click the "update quantity" link
	Then I should have 3 Broomsticks in my cart

(happy path)
Scenario: Updating item quantity in cart on shopping cart page doesn't affect other items in cart
	Given that I have 1 Broomstick and 1 Wand in my cart
	And I visit the shopping cart page
	When I fill in the item quantity for the first item with "3"
	And I click the "update quantity" link
	Then I should have 3 Broomsticks and 1 Wand in my cart

(happy path)
Scenario: Change item quantity in cart on shopping cart page to 0, deleting it from cart
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	When I fill in the item quantity for the first item with "0"
	And I click the "update quantity" link
	Then I should have 0 items in my cart

(sad path)
Scenario: Change item quantity in cart to an integer over 99
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	When I fill in the item quantity for the first item with "9001"
	And I click the "update quantity" link
	Then I should see "You can order up to 99 of each item type"
	And I should have 99 Broomsticks in my cart

(bad path)
Scenario: Change item quantity in cart to a non-integer
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	When I fill in the item quantity for the first item with "ABCD"
	And I click the "update quantity" link
	Then I should see "That's not a valid entry"
	And I should have 1 Broomstick in my cart

#[feature] Visit item pages from cart

(happy path)
Scenario: Visit item page by clicking on line item
	Given that I have 1 Broomstick and 1 Wand in my cart
	And I visit the shopping cart page
	When I click the "Broomstick" link
	Then I should be on the Broomstick item page
	And I should see "Broomstick"
	And I should see "Add to cart"

#[feature] weight-agnostic shipping calculator

(happy path)
Scenarios: Enter valid address to calculate shipping cost
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	And I fill in the shipping address form with "175"
	And I fill in the shipping street form with "W Jackson Blvd"
	And I fill in the shipping city form with "Chicago"
	And I select "IL" from the state dropdown menu
	When I click the "Estimate shipping" link
	Then I should see "Your Shipping Estimate:"
	And I should see "$9.99"

(sad path)
Scenario: User enters a nonexistent shipping address
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	And I fill in the shipping address form with "1178729"
	And I fill in the shipping street form with "W Grackackson Blvd"
	And I fill in the shipping city form with "Chicago"
	And I select "IL" from the state dropdown menu
	When I click the "Estimate shipping" link
	Then I should see "That's not a valid address according to our system"

(sad path)
Scenario: User enters an address but no city (extrapolate to the other fields in form)
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	And I fill in the shipping address form with "175"
	And I fill in the shipping street form with "W Jackson Blvd"
	And I fill in the shipping city form with "Chicago"
	When I click the "Estimate shipping" link
	Then I should see "Please fill out all required forms"

(bad path)
Scenario: User enters an invalid shipping address
	Given that I have 1 Broomstick in my cart
	And I visit the shopping cart page
	And I fill in the shipping address form with "1178728179287sdfklj331"
	When I click the "Estimate shipping" link
	Then I should see "Please enter an address with City, State and Zip

#[feature] add coupon code for discount

(happy path)
Scenario: User enters a valid coupon code
	Given that I have 1 Textbook in my cart
	And the price of a Textbook is $100
	And the "LOCKHART_FAN" coupon code is active
	And I visit the shopping cart page
	When I fill in the coupon code form with "LOCKHART_FAN"
	Then I should see "-20.00"
	And I should see "80.00"


(sad path)
Scenario: User enters an expired or invalid coupon code
	Given that I have 1 Textbook in my cart
	And the price of a Textbook is $100
	And the "SNAPE_SUX" coupon code is not active
	And I visit the shopping cart page
	When I fill in the coupon code form with "SNAPE_SUX"
	Then I should see "That's not currently a valid coupon code"

#[feature] Add another item of the same SKU that's already in user's cart updates qty in cart

(happy path)
Scenario: User clicks "add to cart" on an item of which there is already one in cart
	Given that I have 1 Broomstick in my cart
	And I visit the Broomstick item page
	When I click the "Add to cart" link
	And I visit the shopping cart page
	Then I should see "2 Broomsticks"
	And the cart should have 1 SKU represented

#[feature] When anonymous user logs in, her cart is merged with her account's saved cart

(happy path)
Scenario: Anonymous user logs in with items in cart. Her account also has items saved in its cart
	Given that I am not logged in
	And I have 1 Broomstick and 1 Wand in my cart
	And my login account has 2 Broomsticks and 1 Textbook in its cart
	When I log in
	And I visit the shopping cart page
	Then I should see "3 Broomsticks"
	And I should see "1 Wand"
	And I should see "1 Textbook" 

(sad path)
Scenario: Anonymous user enters wrong information
	Given that I am not logged in
	And I have 1 Broomstick and 1 Wand in my cart
	And my login account has 2 Broomsticks and 1 Textbook in its cart
	When I try to log in and fail
	Then I should see "Invalid credentials"
	When I visit the shopping cart page
	Then I should see "1 Broomstick"
	And I should see "1 Wand"





