Feature: Add Products to Shopping Cart
  As a customer
  I want to add products to my shopping cart
  In order to purchase them

  Background
    Given I am on the hammer page
    And I am logged in

  Scenario: Add An In-stock Product to the Cart (Good Path)
    Given I have 0 hammers in my cart
    And a hammer is in stock
    When I enter 1 in the "Product Quantity" box
    And I click "Add Product to Cart"
    Then I should have 1 hammer in my cart
    And the total cost is $10.00

  Scenario: Add An In-stock Product to a Previous Cart (Good Path)
    Given I have added a "hammer" to my cart
    And a "hammer" is in stock
    And I click "Add Product to Cart"
    Then I should have 2 hammers in my cart
    And the total cost is $20.00

  Scenario: Add a second In-stock Product to the Cart (Good Path)
    Given I have added a "hammer" to my cart
    And the total cost is $10.00
    And a "hammer" is in stock
    When I enter 1 in the "Product Quantity" box
    And I click "Add Product to Cart"
    Then I should have 2 hammers in my cart
    And the total cost is $20.00

  Scenario: Add a different In-stock Product to the Cart (Good Path)
    Given I have added a "hammer" to my cart
    And the total cost is $10.00
    And I am on the screwdriver page
    And a "screwdriver" is in stock
    When I enter 1 in the "Product Quantity" box
    And I click "Add Product to Cart"
    Then I should have 1 hammer in my cart
    And I should have 1 screwdriver in my cart
    And the total cost is $15.00

  Scenario: Add a Negative Quantity of Products to the Cart (Bad Path)
    And a hammer is in stock
    When I enter -1 in the "Product Quantity" box
    And I "click Add Product to Cart"
    Then I should see "Invalid Quantity. Please enter a number greater than zero."

  Scenario: Add a Non-Numeric Quantity of Products to the Cart (Bad Path)
    And a hammer is in stock
    When I enter A in the "Product Quantity" box
    And I "click Add Product to Cart"
    Then I should see "Invalid Entry. Please enter a number."
