Feature: Edit Shopping Cart
  In order to shop online
  As a online customer
  I want to add, remove and change items to the cart 
 
#Happy Path 
  Scenario: add item to the cart
    Given I have an item to add to the cart
    When I add an item to the cart
    Then I should see the item in the cart
    And Total quantity should be item quantity
    And Total cost should be item cost

  Scenario: add multiple items to the cart
    Given I have an item to add to the cart
    And I have an item in the cart 
    When I add another item to the cart
    Then I should see both items in the cart
    And Total quantity should be sum of item quantities
    And Total cost should be sum of cost of all items in the cart

  Scenario: add duplicate items to the cart
    Given I have an item to add to the cart
    And I have an item in the cart 
    When I add same item to the cart
    Then I should see item in the cart
    And Item quantity should be increased by 1
    And Total quantity should be item quantity
    And Total cost should be increased by item cost

  Scenario: remove an item from the cart
    Given I have an item in the cart
    When I remove an item from the cart
    Then I should not see the item in the cart
    And Total quantity should be 0
    And Total cost should be 0

  Scenario: remove an item from the cart with multiple items
    Given I have multiple items in the cart
    When I remove one item from the cart
    Then I should not see the removed item in the cart
    And I should see the remaining items in the cart
    And Total quantity should be sum of remaining item quantities
    And Total cost should be sum of cost of remaining items in the cart

  Scenario: change an item quantity 
    Given I have an item in the cart
    When I change the item quatity
    Then I should see the item in the cart
    And Item quantity should be updated
    And Total quantity should be updated
    And Total cost should be item quantity multiplied by item cost

  Scenario: add items to the cart and then login as user with empty cart
    Given I have valid user with empty cart
    And I have items in the cart as an anonymous user
    When I login as user 
    Then I should have same items in my cart 
  
  Scenario: add items to the cart and then login as user with items in cart
    Given I have valid user with items in cart
    And I have items in the cart as an anonymous user
    When I login as user 
    Then I should have both items in my cart 

#Sad Path
  Scenario: add an unavailable item 
    Given I have an unavailable item
    When I add an item to the cart
    Then I should see an error that the item is unavailable
    And I should not see the item in the cart
    And Total quantity should be 0
    And Total cost should be 0

  Scenario: change an item quantity to unavailable amount
    Given I have an item in the cart
    When I change the item quantity to 1000
    Then I should see an error that there are only 10 items available
    And I should see the item in the cart
    And Item quantity should not be updated
    And Total quantity should be item quantity
    And Total cost should be item cost

#Bad Path
  Scenario: change an item quantity to negative
    Given I have an item in the cart
    When I change the item quantity to negative 
    Then I should see an Error that the quantity is invalid 
    And I should see the item in the cart
    And Item quantity should not be updated
    And Total quantity should be item quantity
    And Total cost should be item cost