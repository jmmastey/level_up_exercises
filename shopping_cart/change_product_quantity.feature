Ability: Change Product Quantities in Cart

  As a customer
  I need the ability to change the quantity of products in my cart
  So that I can efficiently update my purchase choices

  Background:
    Given an authenticated customer
    And a shopping cart with three of the same product

  Scenario: Increase quantity of product
    When the quantity of the product is increased by two
    Then the shopping cart contains five of the product

  Scenario: Increase quantity of product beyond available product quantity
    Given a product that that has two items in stock
    And that product is in the cart with a quantity of two
    When the quantity of that product is increased
    Then an unable to fulfill quantity message will be displayed

  Scenario: Increase quantity of product beyond allowed product quantity
    Given a product that is limited to one purchase per order
    And that product is in the cart
    When the quantity of that product is increased
    Then a purchase limit restriction will be displayed

  Scenario: Decrease quantity of products
    When the quantity of the product is decreased by two
    Then the shopping cart contains one of the product

  Scenario: Decrease total quantity of product
    When the quantity of the product is decreased by three
    Then the shopping cart is empty

  Scenario: Decrease quantity of product by more than total quantity
    When the quantity of the product is decreased by four
    Then the shopping cart is empty

  Scenario Outline: Product quantities must be a whole number
    When the quantity is changed to an <invalid> value
    Then an invalid quantity message will be displayed

    Examples:
      | invalid |
      | -1      |
      | 0.1     |
      | ab      |
      | ""      |
