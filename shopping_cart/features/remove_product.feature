Feature: Remove a product from the shopping cart
  A shopping cart that already has items added should allow for the user
  to remove items and have totals updated accordingly.

  Background:
    Given I have a shopping cart with 10 "Item 1" in it
    Given I have a shopping cart with 2 "Item 2" in it
    Given I have a shopping cart with 5 "Item 3" in it
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $30.00
    And I am on the shopping cart page

  @happy_path
  Scenario: Remove a item
    When I remove "Item 1"
    Then I should not see "Item 1" in the shopping cart
    And I should see 2 of "Item 2" in the shopping cart
    And I should see 5 of "Item 3" in the shopping cart
    And I should see $40.00 of "Item 1" in the shopping cart
    And I should see $150.00 of "Item 3" in the shopping cart
    And I should see items subtotal of $190.00 in the shopping cart

  @happy_path
  Scenario: Remove all items
    When I empty the shopping cart
    Then I should see items subtotal of $0 in the shopping cart

  @happy_path
  Scenario: Remove an item by setting quantity to zero
    When I modify quantity of "Item 1" to 0
    And I press "Recalculate"
    Then I should not see "Item 1" in the shopping cart
    And I should see items subtotal of $190.00 in the shopping cart

  @bad_path
  Scenario: Remove all products and attempt to remove all again
    When I empty the shopping cart
    And I should see items subtotal of $0 in the shopping cart
    And I empty the shopping cart
    And I should see items subtotal of $0 in the shopping cart

  @bad_path
  Scenario: Attempt to remove a product not in the shopping cart
    When I remove "Item 90"
    Then I should see 10 of "Item 1" in the shopping cart
    Then I should see 2 of "Item 2" in the shopping cart
    Then I should see 5 of "Item 3" in the shopping cart
    And I should see items subtotal of $290.00 in the shopping cart
