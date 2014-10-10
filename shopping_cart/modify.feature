Feature: Modify shopping cart content
  In order to buy the items I need to
  As a shopper
  I want to be able to modify or remove items from the shopping cart

  Background:
    Given the shopping cart contains 1 "Widget A"
    And the shopping cart contains 2 "Widget B"
    And the shopping cart contains 3 "Widget C"
    And "Widget A" costs $1.00
    And "Widget B" costs $10.00
    And "Widget C" costs $100.00
    And I am viewing the shopping cart

  @happy_path
  Scenario: Remove item
    When I remove "Widget A"
    Then I should see 5 items in the shopping cart
    And I should see 2 "Widget B" in the shopping cart
    And I should see 3 "Widget C" in the shopping cart
    And I should see subtotal price $320.00

  @happy_path
  Scenario: Remove all items from shopping cart
    When I clear the shopping cart
    Then I should see 0 items in the shopping cart
    And I should see subtotal price $0.00

  @bad_path
  Scenario: Remove item not in the cart
    When I remove "Widget D" from the shopping cart
    Then I should see 6 items in the shopping cart
    And I should see 1 "Widget A" in the shopping cart
    And I should see 2 "Widget B" in the shopping cart
    And I should see 3 "Widget C" in the shopping cart
    And I should see subtotal price $321.00

  @bad_path
  Scenario: Remove all items from shopping cart and try to remove again
    When I clear the shopping cart
    And I remove "Widget A" from the shopping cart
    Then I should see 0 items in the shopping cart
    And I should see subtotal price $0.00

  @happy_path
  Scenario: Increase quantity of an item
    When I change the quantity of "Widget A" to 2
    And I press "Update"
    Then I should see 7 items in the shopping cart
    And I should see 2 "Widget A" in the shopping cart
    And I should see 2 "Widget B" in the shopping cart
    And I should see 3 "Widget C" in the shopping cart
    And I should see subtotal price $322.00

  @happy_path
  Scenario: Decrease quantity of an item
    When I change the quantity of "Widget B" to 1
    And I press "Update"
    Then I should see 5 items in the shopping cart
    And I should see 1 "Widget A" in the shopping cart
    And I should see 1 "Widget B" in the shopping cart
    And I should see 3 "Widget C" in the shopping cart
    And I should see subtotal price $311.00

  @happy_path
  Scenario: Set quantity to zero
    When I change the quantity of "Widget A" to 0
    And I press "Update"
    Then I should see 5 items in the shopping cart
    And I should see 2 "Widget B" in the shopping cart
    And I should see 3 "Widget C" in the shopping cart
    And I should see subtotal price $320.00

  @bad_path
  Scenario: Set quantity to negative
    When I change the quantity of "Widget A" to -1
    And I press "Update"
    Then I should see 5 items in the shopping cart
    And I should see 2 "Widget B" in the shopping cart
    And I should see 3 "Widget C" in the shopping cart
    And I should see subtotal price $320.00
