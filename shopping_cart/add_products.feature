Ability: Add Products to Cart

  As a customer
  I need the ability to add products to a cart
  So that I can make purchases

  Background:
    Given an authenticated customer

  Scenario: Adding a single product
    Given a product that is in stock
    When the product is added to the cart
    Then the cart contains one product line item

  Scenario: Adding a single product multiple times
    Given a product that is in stock
    When six of the products are added to the cart
    Then the cart contains six product line items

  Scenario: Adding multiple products
    Given two products that are in stock
    When one of each product is added to the cart
    Then the cart contains one line item for each product

  Scenario: Adding out of stock products
    Given a product that is out of stock
    When attempting to add that product to the cart
    Then an out of stock message will be displayed

  Scenario: Adding an unavailable product quantity
    Given a product that that has two items in stock
    When attempting to add three of that product to the cart
    Then the cart will contain two line items for the product
    And an unable to fulfill quantity message will be displayed

  Scenario: Adding discontinued products
    Given a product that is discontinued
    When attempting to add that product to the cart
    Then a product discontinued message will be displayed
    And an alternate product selection will be displayed
