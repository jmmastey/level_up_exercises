Feature: adding products to the shopping cart
  In order to make purchases
  A user adds products to their cart


  Scenario: a visitor (not logged in) adds a product to the cart
    Given a user that is not logged in
    When they add a product to their cart
    Then the cart contains that product

  Scenario: a visitor adds a product to the cart then logs in
    Given a user that is not logged in
    And they add a product to their cart
    When they login
    Then they see the item in their cart

  Scenario: a user (logged in) adds a product to the cart
    Given a user that is logged in
    When they add a product to their cart
    Then the cart contains that product

  Scenario: a user adds a product to the cart a second time
    Given a user that is logged in
    When they add a product to their cart
    And they add the same product to their cart a second time
    Then the cart contains one of those products with a quantity of 2