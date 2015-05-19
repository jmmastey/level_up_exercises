# Feature: Shopping Cart

## Scenario: User adds item to cart
  Given I am an User
  When I go to an Item page
  And I click "Add Item To Cart"
  Then the quantity of items in my cart should increase by 1
  And the warehouse inventory for that item should decrease by 1
  And the cart information is saved to cookie
  
## Scenario: User removes item from cart
  Given I am an User
  And I have 1 or more items in my cart
  And I am viewing the Cart page
  When I click "Remove From Cart"
  Then the corresponding item is removed form my cart completely
  And the warehouse inventory for that Item increases accordingly
  And the cart information is saved to cookie
  
## Scenario: User changes product quantity in cart
  Given I am an User
  And I have 1 or more items in my cart
  And I am viewing the Cart page
  When I edit the Quantity field
  And click the "Update Cart" button
  Then the corresponding item's quantity is updated
  And the warehouse inventory for that Item increases or decreases accordingly
  And the cart information is saved to cookie
  
## Scenario: User views product information for items in the cart
  Given I am an User
  And I have 1 or more items in my cart
  And I am viewing the Cart page
  When I click an Item's Title
  Then I am taken to the corresponding Item page

## Scenario: User views order totals
  Given I am an User
  And I have 1 or more items in my cart
  And I am viewing the Cart page
  Then the subtotal displayed is a total of all Items in my cart (before tax)
  And the total displayed is a total of all Items in my cart (after tax)

## Scenario: Get estimated shipping costs for cart
  Given I am an User
  And I have 1 or more items in my cart
  And I am viewing the Cart page
  When I enter a ZIP code in the ZIP Code field
  And click the "Estimate Shipping" button
  Then I should see estimated shipping costs display beneath the field
  
## Scenario: Apply coupon/discount codes to cart
  Given I am an User
  And I have 1 or more items in my cart
  And I am viewing the Cart page
  When I enter a valid coupon code in the Coupon Code field
  And click the "Apply Coupon Code" field
  Then the corresponding amount is subtracted from my subtotal

## Scenario: Revisiting a previous cart (authenticated users)
  Given I am a Prior User
  And I am logged in
  And I have a items in my cart from a previous session
  And my previoous session was under the same user account
  Then the contents of my previous cart remain as part of my current cart

## Scenario: Revisiting a previous cart (unauthenticated users)
  Given I am a Prior User
  And I am not logged in
  And I have a items in my cart from a previous session
  And my previous session happened on the same device I am currently using
  Then the contents of my previous cart remain as part of my current cart