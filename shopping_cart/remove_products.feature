Ability: Remove Products from Cart

  As a customer
  I need the ability to remove products from a cart
  So that I can change my mind on purchase decisions

  Background:
    Given an authenticated customer

  Scenario: Removing a single product
    Given a shopping cart with a single product
    When that single product is removed
    Then the shopping cart is empty

  Scenario: Removing multiple products
    Given a shopping cart with three products
    When one product is removed
    Then the shopping cart contains two products

  Scenario: Removing package products prompts a warning
    Given a shopping cart with a package product
    When the package product is removed
    Then a remove product components warning is displayed

  Scenario: Removing package products with components
    Given a shopping cart with a package product
    When the package product is removed
    And the customers agrees to remove the product components
    Then the shopping cart is empty

  Scenario: Removing package products but not components
    Given a shopping cart with a package product
    When the package product is removed
    And the customers does not agree to remove the product components
    Then a cannot purchase components separately message is displayed

  Scenario: Removing a component products prompts a warning
    Given a shopping cart with a package product
    When a component product is removed
    Then a removing component warning is displayed

  Scenario: Removing a component product
    Given a shopping cart with a package product
    When a component product is removed
    And the customer accepts the component warning
    Then the package product is still in the cart
    But the component product is removed
