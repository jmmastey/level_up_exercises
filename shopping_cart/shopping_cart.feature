Feature: Shopping Cart
  Scenario: Add Item to Cart
    Given I am on an item page
    When I add the item to the cart
    Then the cart should contain the item

  Scenario: Add Out-of-Stock Item to Cart
    Given I am on an item page
      And the item is out of stock
    When I add the item to the cart
    Then I should see an error message
     And the cart should not contain the item

  Scenario: Add Non-Existent Item to Cart
    Given I am on an item page
    When I add an invalid item to the cart
    Then I should see an error message
     And the cart should not contain the invalid item

  Scenario: Remove Item from Cart
    Given I am viewing the cart
      And the cart contains an item
    When I remove the item from the cart
    Then the cart should not contain the item

  Scenario: Remove Non-Existent Item from Cart
    Given I am viewing the cart
      And the cart contains an item
    When I remove another item from the cart
    Then I should see an error message
     And the cart should contain an item

  Scenario: Change Quantity
    Given I am viewing the cart
      And the cart contains an item
    When I set the quantity of the item to 3
    Then the cart should contain 3 of the item

  Scenario: Set Quantity to 0
    Given I am viewing the cart
      And the cart contains an item
    When I set the quantity of the item to 0
    Then the cart should not contain the item

  Scenario: View Item from Cart
    Given I am viewing the cart
      And the cart contains an item
    When I click the item link
    Then I should be on the item page

  Scenario: Shipping Estimate
    Given I am on the checkout page
    When I enter my address
     And I request a shipping estimate
    Then I should see a shipping estimate line item

  Scenario: Shipping Estimate Outside Shipping Area
    Given I am on the checkout page
    When I enter an address outside shipping area
     And I request a shipping estimate
    Then I should see an error message
     And I should not see a shipping estimate line item

  Scenario: Shipping Estimate Invalid Address
    Given I am on the checkout page
    When I enter an invalid address
     And I request a shipping estimate
    Then I should see an error message
     And I should not see a shipping estimate line item

  Scenario: Add Coupon
    Given I am on the checkout page
    When I enter a valid coupon code
    Then I should see a discount line item

  Scenario: Add Expired Coupon
    Given I am on the checkout page
    When I enter an expired coupon code
    Then I should see an error message
     And I should not see a discount line item

  Scenario: Add Invalid Coupon
    Given I am on the checkout page
    When I enter an invalid coupon code
    Then I should see an error message
     And I should not see a discount line item

  Scenario: Add Existing Item to Cart
    Given I am on an item page
      And the cart contains 1 of the item
    When I add the item to the cart
    Then the cart should contain 2 of the item

  Scenario: Log In With Same Item Already in Cart
    Given I am viewing the cart
      And the cart contains an item
    When I log in
     And my saved cart already contains the item
    Then the cart should contain 2 of the item

  Scenario: Log In With Different Item Already In Cart
    Given I am viewing the cart
      And the cart contains an item
    When I log in
     And my saved cart already contains another item
    Then the cart should contain the item
     And the cart should contain the other item
