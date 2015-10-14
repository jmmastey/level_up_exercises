Feature: Shopping Cart
  As a potential customer
  I want a shopping cart to save items I'm interested in
  So I can review and purchase everything I'm interested in

  @HappyTask
  Scenario: Should be able to add product to Shopping Cart
    Given I view the "Lego Set" product page
    When I click "Add to cart"
    Then I should see I have 1 item in my cart

  @HappyTask
  Scenario: Should be able to remove product from Shopping Cart
    Given I added "Lego Set" to my cart
    When I am on the shopping cart page
    And I click "Remove Lego Set" on the page
    Then "Lego Set" should no longer be in my cart

  @HappyTask
  Scenario: Should be able to adjust quanities of a product in Shopping Cart
    Given I am on the shopping cart page with "Lego Set" in my cart
    When I set the "Lego Set" quantity to "2" and click "Update"
    Then I should see "Quantity: 2" in the "Lego Set" row

  @HappyTask
  Scenario: Should remove item if quantity is set to 0
    Given I am on the shopping cart page with "Lego Set" in my cart
    When I set the "Lego Set" quantity to "0" and click "Update"
    Then "Lego Set" should no longer be in my cart

  @HappyTask
  Scenario: Should be able to visit product page from shopping cart
    Given I am viewing my cart's contents
    When I click on the "Lego Set" row
    Then I should be on a page that says "Product: Lego Set"

  @HappyTask
  Scenario: Should be able to get shipping estimates
    Given I am on the checkout page
    When I enter my Shipping Address "175 W. Jackson"
    And I enter my City "Chicago"
    And I choose my state "IL"
    And I enter my zipcode "60606"
    Then I should see my shipping estimate to have "3.00"

  @HappyTask
  Scenario: Should be able to enter a coupon code
    Given I am on the checkout page
    When I enter my coupon "FREESHIP"
    Then I should see "FREESHIP" under my list of active coupons

  @HappyTask
  Scenario: Shopping cart contents should stay with user regardless of session
    Given I am not logged in
    And I have added "Lego Set" and "Glue" to my shopping cart
    When I click "Login" and enter my valid credentials
    And I am on the shopping cart page
    Then I should see "Lego Set" and "Glue" in my shopping cart

  @HappyTask
  Scenario: Should increase quantity of item in cart if it has the same SKU
    Given my shopping cart already has "Lego Set"
    When I view the "Lego Set" product page
    And I click "Add to cart"
    And I am on the shopping cart page
    Then I should see "Quantity: 2" in the "Lego Set" row

  @HappyTask
  Scenario: Should be able to checkout if I have items in cart
    Given I am on the shopping cart page with "Lego Set" in my cart
    Then I should see a "Checkout" button

  @SadTask
  Scenario: Should not be logged in with invalid credentials
    Given I am not logged in
    When I click "Login" and enter my invalid credentials
    Then I should still not be logged in

  @SadTask
  Scenario: Should not be able to checkout without items in cart
    Given I have not added anything to my cart
    When I am on the shopping cart page
    Then I should not see a "Checkout" button

  @SadTask
  Scenario: Should not be able to checkout when I make my cart empty
    Given I am on the shopping cart page with "Lego Set" in my cart
    When I click "Remove" on the "Lego Set" row
    And my cart is now empty
    Then I should not see a "Checkout" button

  @SadTask
  Scenario: Should not apply invalid coupons to shopping cart
    Given I am on the checkout page
    When I enter my coupon "FREESTUFFZ"
    Then I should not see "FREESTUFFZ" under my list of active coupons

  @BadTask
  Scenario: Should have error message with invalid login credentials
    Given I am not logged in
    When I click "Login" and enter my invalid credentials
    Then I should see a message "Invalid username or password"

  @BadTask
  Scenario: Should have error message with no items in cart
    Given I have not added anything to my cart
    When I am on the shopping cart page
    Then I should see a message "Your cart is empty"

  @BadTask
  Scenario: Should have error message for invalid coupon
    Given I am on the checkout page
    When I enter my coupon "FREESTUFFZ"
    Then I should see a message "Invalid or expired coupon"

  @BadTask
  Scenario: Should not see shipping estimate for invalid address
    Given I am on the checkout page
    When I enter my Shipping Address "1234 Sad Path Rd."
    And I enter my City "Sadsville"
    And I choose my state "IL"
    And I enter my zipcode "0000"
    Then I should see my shipping estimate to have "Invalid Address"
