Feature: Shipping estimates based on user's location

# Happy: :^D
Scenario: Destination ZIP code for calculating shipping
  Given anything
  When I am viewing the cart item page
  Then I see a ZIP code entry control
  And a message "Enter ZIP code for estimated shipping"

Scenario: Destination ZIP code filled in for authenticated users
  Given I am an authenticated user
  When I am viewing the cart item page
  Then I see my registered ZIP code in the ZIP code entry control

Scenario: Shipping line item
  Given I have an order with item subtotal $10
  When I enter a valid ZIP code in the ZIP code entry control
  Then I see a shipping line item

Scenario: Override profile ZIP code
  Given I am an authenticated user
  And I have an order with item subtotal $10
  And I see my registered ZIP code in the ZIP code entry control
  When I enter an alternative valid ZIP code in the ZIP code entry control
  Then I see an updated shipping line item
   
# Sad: ;^(

Scenario: Enter invalid ZIP code
  Given I have an order with item subtotal $20 in my cart
  When I enter an invalid ZIP code in the ZIP code entry control
  Then I see an invalid ZIP code warning
  And I do not see a shipping line item

# Bad: >:^(

Scenario: Deliberately over-length ZIP
  Given I have an ordert with item subtotal $20 in my cart
  And I craft a cart request with a 1MB ZIP code value
  When I issue the cart request
  Then I see a general error page
  And I do not see any of the ZIP code value echoed in page content
  And no change is made to my cart


