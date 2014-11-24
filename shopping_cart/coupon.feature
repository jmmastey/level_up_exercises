Feature: Add Coupons to Shopping Cart
  As a customer
  I want to add coupons in my shopping cart
  In order to reduce my costs

  Background
    Given I am on the Shopping Cart page
    And I have added a hammer to my cart

  Scenario: Add Valid Coupon (Good Path)
    Given I am logged in
    And my total cost is $10.00
    When I add the coupon code "111222" to the "Coupon Code" box
    And I click "Add Coupon"
    Then my total cost is $8.00

  Scenario: Add Invalid Coupon (Sad Path)
    Given I am logged in
    When I add the coupon code "000000" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Sorry. That is not a valid coupon code. Please enter a valid code."

  Scenario: Add Expired Coupon (Sad Path)
    Given I am logged in
    When I add the coupon code "999999" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Sorry. That coupon code has expired."

  Scenario: Add Incorrectly Formatted Coupon (Bad Path)
    Given I am logged in
    When I add the coupon code "lkasdjflkajfd" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Please enter a code in the format: 123456."

  Scenario: Forget to Add Coupon (Bad Path)
    Given I am logged in
    And I click "Add Coupon"
    Then I should see "Please enter a coupon code."

  Scenario: Not logged in (Bad Path)
    Given I am not logged in
    And my total cost is $10.00
    When I add the coupon code "111222" to the "Coupon Code" box
    And I click "Add Coupon"
    Then I should see "Please log in to enter a coupon code."
