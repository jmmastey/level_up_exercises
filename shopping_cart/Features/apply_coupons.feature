Feature: Apply Coupons
  In order to save on cost / shipping
  As a Customer
  I want to Enter a coupon code to the Cart

  Scenario:  Customer wants to add coupon code to reduce item cost
    Given I have Items in the cart
    When I enter a valid cost reduction coupon
    Then I should see the total and value cost of the cart change based on the coupon's terms

  Scenario:  Customer wants to add coupon code to reduce shipping cost
    Given I have Items in the cart
    When I enter a valid shipping cost reduction coupon
    Then I should see the total and shipping cost of the cart change based on the coupon's terms

  Scenario:  Customer wants to remove a successfully applied coupon
    Given I have Items in the cart
    When I enter a valid cost reduction coupon
    Then I should see the total and value cost of the revert to its original value based on the coupon's terms

  Scenario:  Customer wants to remove a successfully applied shipping coupon
    Given I have Items in the cart
    When I enter a valid shipping cost reduction coupon
    Then I should see the total and shipping cost of the revert to its original value based on the coupon's terms


  Scenario:  Customer wants to add an expired shipping cost reduction coupon code
    Given I have Items in the cart
    When I enter an expired shipping cost reduction coupon
    Then I should see a warning that the coupon is expired
    And I should see no change in the carts shipping cost

  Scenario:  Customer wants to add an expired cost reduction coupon code
    Given I have Items in the cart
    When I enter an expired cost reduction coupon
    Then I should see a warning that the coupon is expired
    And I should see no change in the cart's cost

  Scenario:  Customer wants to add a multiple coupon code
    Given I have Items in the cart
    And I successfully added a coupon code
    When I add a 2nd valid coupon code
    Then I should see a warning that only one coupon is allowed
    And the last coupon was applied
    And I should see that the last coupon changed the cart's cost

  Scenario:  Customer wants to remove all items after a coupon was applied
    Given I have Items in the cart
    And I successfully added a coupon code
    When Remove all Items from the cart
    Then I should see the cart is empty with a balance of zero

  Scenario:  Customer wants to add coupon to an empty cart
    Given I have no Items in the cart
    When I add a coupon to the cart
    Then I should see a warning that coupons are not allowed on empty carts
    And I should see the cart is empty with a balance of zero

  Scenario:  Customer wants to add an expired coupon after successfully applying a coupon
    Given I have no Items in the cart
    And I successfully added a coupon code
    When I add an expired coupon to the cart
    Then I should see a warning that the coupon is expired
    And I should see the cart totals have not changed

  Scenario:  Customer wants to add an invalid coupon after successfully applying a coupon
    Given I have no Items in the cart
    And I successfully added a coupon code
    When I add an invalid coupon to the cart
    Then I should see a warning that the coupon is invalid
    And I should see the cart totals have not changed