Feature: Update products in shopping cart

  Background:
    Given I have a shopping cart with 10 "Item 1" in it
    Given I have a shopping cart with 1 "Item 2" in it
    Given I have a shopping cart with 1 "Item 3" in it
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $30.00
    And I am on the shopping cart page

  @happy_path
  Scenario: Increase the quantity of a product
    When I modify quantity of "Item 1" to 11
    And I press "Recalculate"
    Then I should see 11 of "Item 1" in the shopping cart
    And I should see items subtotal of $160.00 in the shopping cart

  @happy_path
  Scenario: Increase the quantities of multiple products
    When I modify quantity of "Item 1" to 11
    When I modify quantity of "Item 2" to 2
    And I press "Recalculte"
    Then I should see 11 of "Item 1" in the shopping cart
    And I should see 2 of "Item 2" in the shopping cart
    And I should see items subtotal of $180.00 in the shopping cart

  @happy_path
  Scenario: Decrease the quantity of a product
    When I modify quantity of "Item 1" to 9
    And I press "Recalculate"
    Then I should see 9 of "Item 1" in the shopping cart
    And I should see items subtotal of $140.00 in the shopping cart

  @sad_path
  Scenario: Set a quantity of a product to a negative number
    When I modify quantity of "Item 1" to -10
    And I press "Recalculate"
    Then I should see 10 of "Item 1" in the shopping cart
    And I should see items subtotal of $150.00 in the shopping cart
