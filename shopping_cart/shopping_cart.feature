Feature: Add/Remove/Change quantities in cart
  In order to verify that I can modify my shopping card
  As a customer
  I should be able to add/remove/and change quantities of items in my cart

  @happy
  Scenario: Add product to cart
    Given I visit a product page
    When I click on "Add to cart"
    Then I the product should appear in my cart

  @sad
  Scenario: Added product lost on log in
    Given I have added a prodcut to my cart
    When I log in as a user with something different in their cart
    And I visit my shopping cart page
    Then the added product should not appear in my cart

  @happy
  Scenario: Remove product from cart
    Given I have added a product to my cart
    When I visit my shopping cart page
    And I remove the product from my cart
    Then I the product should not appear in my cart

  @sad
  Scenario: No product to remove
    Given I visit my shopping cart page
    Then I should have no product to remove

  @happy
  Scenario: Increase quantity of product in cart
    Given I have added a product to my cart
    When I visit my shopping cart page
    And I increase the quantity of the product by 1
    Then I the quantity of the product in my cart should be 2

  @happy
  Scenario: Decrease quantity of product in cart
    Given I have added a product to my cart with quantity 2
    When I visit my shopping cart page
    And I decrease the quantity of the product by 1
    Then I the quantity of the product in my cart should be 1

Feature: Link from product in cart to product page
  In order to verify that I can get to the product page from my shopping cart
  As a customer
  I should be able to get to the product page from my shopping cart

  @happy
  Scenario: Click on product in shopping cart
    Given I have added a product to my cart
    When I visit my shopping cart page
    And I click on the product's name
    Then I should be on the product's page

Feature: Get shipping estimate
  In order to verify that I can enter my address and get shipping estimates
  As a customer
  I should be able to enter my address and get shipping estimates

  @happy
  Scenario: Enter address and get shipping estimate
    Given I visit my shopping cart page
    When I enter my address into shipping information
    And I click on "Get shipping estimate"
    Then I should get a shipping estimate

  @bad
  Scenario: Enter an invalid address
    Given I visit my shopping cart page
    When I enter an invalid address into shipping information
    And I click on "Get shipping estimate"
    Then I should be notified that the address I entered is invalid

Feature: Add coupons
  In order to verify that I can enter and use valid coupon codes
  As a customer
  I should be able to enter and use valid coupon codes

  @happy
  Scenario: Add valid coupons
    Given I visit my shopping cart page
    When I enter the coupon code "TEST_VALID_CODE"
    Then I should recieve the coupon

  @bad
  Scenario: Add invalid coupons
    Given I visit my shopping cart page
    When I enter the coupon code "TEST_INVALID_CODE"
    Then I should be notified that the coupon code I entered is invalid
