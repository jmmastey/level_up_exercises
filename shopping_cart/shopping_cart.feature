Feature: Shopping Cart
  Scenario: Add Item to Cart
    Given I am on an item page
    When I add the item to the cart
    Then the cart should contain the item

  Scenario: Remove Item from Cart
    Given I am viewing the cart
      And the cart contains an item
    When I remove the item from the cart
    Then the cart should not contain the item

  Scenario: Change Quantity
    Given I am viewing the cart
      And the cart contains an item
    When I set the quantity of the item to 3
    Then the cart should contain 3 of the item

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

  Scenario: Add Coupon
    Given I am on the checkout page
    When I enter a valid coupon code
    Then I should see a discount line item

  Scenario: Add Expired Coupon
    Given I am on the checkout page
    When I enter an expired coupon code
    Then I should see an error message
     And I should not see a discount line item

  Scenario: Add Existing Item to Cart
    Given I am on an item page
      And the cart contains 1 of an item
    When I add the item to the cart
    Then the cart should contain 2 of the item

  Scenario: Log In With Items Already in Cart
    Given I am viewing the cart
      And the cart contains an item
    When I log in
     And I had the same item saved
    Then the cart should contain 2 of the item

  Scenario: Log In With Same Items Already In Cart
    Given I am viewing the cart
      And the cart contains an item
    When I log in
     And I had a different item saved
    Then the cart should contain the item
     And the cart should contain the other item
