Feature: shopper shops
  
  As a shopper
  I want to a decent shopping experience
  So I can buy a ton of stuff easily

  Scenario: add to cart
    Given I am on a PDP
    When I click Add To Cart
    Then I should see this product in the minicart
    
  Scenario: add duplicate item to cart
    Given I am on a PDP
    And I have already added this product to the cart
    When I click Add To Cart
    Then I should see this product in the minicart with quantity 2
    
  Scenario: merging authenticated and anonymous cart
    Given I have previously added to my cart in a logged in state
    And I have just added to my cart in an anonymous state
    When I log in
    And I visit the cart page
    Then I should see both products in my cart
    
  Scenario: remove from cart
    Given I am on the cart page with product in my cart
    When I click remove
    Then I should not see the product
    
  Scenario Outline: update quantity
    Given I am on the cart page with product in my cart
    When I fill in "quantity" with "<new_qty>"
    Then I should see "<qty_result>"
  Examples:
    | new_qty | qty_result |
    | 0       | Removed    |
    | 2       | Qty: 2     |
    | 1       | Qty: 1     |
    | 400     | Qty: 1     |
    |         | Qty: 1     |
    | abc     | Qty: 1     |
    | -1      | Qty: 1     |

  Scenario: view PDP from cart
    Given I am on the cart page with product in my cart
    When I click on a product
    Then I should be on a PDP
    
  Scenario Outline: estimate shipping cost
    Given I am on the cart page with product in my cart
    When I fill in "Zip Code" with "<zip>"
    And I press "Calculate Shipping"
    Then I should see "<shipping_cost>"
  Examples:
    | zip   | shipping_cost |
    | 60606 | 5.95          |
    | 90210 | 100.00        |
    |       | N/A           |
  
  Scenario: add coupons
    Given I am on the cart page with product in my cart
    When I fill in "coupon code" with "<coupon>"
    And I press "Add Coupon"
    Then I should see "<coupon_result>"
  Examples:
    | coupon | coupon_result           |
    | ABC    | Coupon applied          |
    | abc    | Coupon applied          |
    | 123    | Not a valid coupon code |
    |        | Not a valid coupon code |
    | CDE    | Coupon expired          |
