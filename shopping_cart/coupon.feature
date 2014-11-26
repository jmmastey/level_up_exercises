Feature: Add Coupons to Shopping Cart
  As a customer
  I want to add coupons in my shopping cart
  In order to reduce my costs

  Background
    Given I am on the Shopping Cart page
    And the coupon code 111222 takes 20% off an order
    And I have added 1 hammer to my cart
    And my total cost is $10.00

  Scenario Outline: Using Coupons
    Given I am logged <login_status>
    When I add the coupon code <code> to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see <message>

    Examples:
      | login_status |  code  |                 message                    |
      |      in      | 111222 | Total cost is $8.00                        | (Good Path)
      |      in      | 000000 | Sorry. That is not a valid coupon code.    | (Sad Path)
      |      in      | 999999 | Sorry. That coupon code has expired.       | (Sad Path)
      |      in      | lkasdd | Please enter a code in the format: 123456. | (Bad Path)
      |      out     | 111222 | Please log in to enter a coupon code.      | (Bad Path)
      |      in      |  none  | Please enter a coupon code.                | (Bad Path)

  Scenario: Add a valid coupon and estimate shipping (Good Path)
    Given I am logged in
    And my total cost is $10.00
    When I enter a valid address
    And I click "Submit My Address"
    Then I should see "Your estimated shipping costs are $5.00"
    And I should see "Total cost is $15.00"
    When I add the coupon code "111222" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Total cost is $13.00"

  Scenario: Add the same valid coupon twice (Sad Path)
    Given I am logged in
    And my total cost is $10.00
    When I add the coupon code "111222" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Total cost is $8.00"
    When I add the coupon code "111222" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "You have already entered that coupon code"
    And I should see "Total cost is $8.00"

  Scenario: Add two different valid coupons (Sad Path)
    Given I am logged in
    And my total cost is $10.00
    When I add the coupon code "111222" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Total cost is $8.00"
    When I add the coupon code "222111" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "You have already entered a coupon code"
    And I should see "Total cost is $8.00"
