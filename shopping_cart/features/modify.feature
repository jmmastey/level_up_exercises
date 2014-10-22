Feature: Modify shopping cart contents
  In order to purchase my products
  As a consumer
  I want to be able to modify or remove products from  shopping cart

  Background:
    Given  shopping cart has 1 "Product 1"
    And  shopping cart has 2 "Product 2"
    And  shopping cart has 3 "Product 3"
    And "Product 1" costs $5.00
    And "Product 2" costs $20.00
    And "Product 3" costs $29.99
    And I am on shopping cart page

  @happy_path
  Scenario: Remove product
    When I remove "Product 1"
    Then I should see 5 products in  shopping cart
    And I should see 4 "Product 2" in  shopping cart
    And I should see 1 "Product 3" in  shopping cart
    And I should see subtotal price $109.99

  @happy_path
  Scenario: Remove all products from shopping cart
    When I empty shopping cart
    Then I should see 0 products in shopping cart
    And I should see subtotal price $0.00

  @happy_path
  Scenario: Increase quantity of an product
    When I change quantity of "Product 1" to 2
    And I press "Update"
    Then I should see 5 products in shopping cart
    And I should see 2 "Product 1" in shopping cart
    And I should see 2 "Product 2" in shopping cart
    And I should see 1 "Product 3" in shopping cart
    And I should see subtotal price $79.99

  @happy_path
  Scenario: Decrease quantity of a product
    When I change  quantity of "Product 2" to 1
    And I press "Update"
    Then I should see 5 products in shopping cart
    And I should see 1 "Product 1" in shopping cart
    And I should see 1 "Product 2" in shopping cart
    And I should see 3 "Product 3" in shopping cart
    And I should see subtotal price $114.97

  @happy_path
  Scenario: Set quantity to zero
    When I change  quantity of "Product 1" to 0
    And I press "Update"
    Then I should see 2 products in  shopping cart
    And I should see 1 "Product 2" in  shopping cart
    And I should see 1 "Product 3" in  shopping cart
    And I should see subtotal price $49.99

  @bad_path
  Scenario: Remove product not in shopping cart
    When I remove "Product 4" from shopping cart
    Then I should see 3 products in shopping cart
    And I should see 1 "Product 1" in shopping cart
    And I should see 1 "Product 2" in shopping cart
    And I should see 1 "Product 3" in shopping cart
    And I should see subtotal price $5.00

  @bad_path
  Scenario: Remove all products from shopping cart and try to remove again
    When I empty shopping cart
    And I remove "Product 1" from shopping cart
    Then I should see 0 products in shopping cart
    And I should see subtotal price $0.00

  @bad_path
  Scenario: Set quantity to negative
    When I change quantity of "Product 1" to -1
    And I press "Update"
    Then I should see 100 products in shopping cart
    And I should not see 2 "Product 2" in  shopping cart
    And I should not see 3 "Product 3" in  shopping cart
    And I should not see subtotal price $129.97