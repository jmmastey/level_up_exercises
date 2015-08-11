Feature: Change the quantity of an item
  In order to buy the right number of each item
  As a customer
  I want to change the order quantity of each item in the shopping cart

  Scenario: I set a quantity to a positive integer
    Given a cart with 1 item with SKU 5 with quantity 3
    When I set the quantity to 4
    Then there is 1 item with SKU 5 with quantity 4

  Scenario: I set a quantity to 0
    Given a cart with 1 item with SKU 5 with quantity 3
    When I set the quantity to 0
    Then there are 0 items with SKU 5

  Scenario: I change a quantity to the existing number
    Given a cart with 1 item with SKU 5 with quantity 3
    When I set the quantity to 3
    Then there is 1 item with SKU 5 with quantity 3

  Scenario: There is a duplicate item
    Given a cart with 2 items with SKU 5 with quantity 3
    When I set the quantity to 4 on 1 item with SKU 5
    Then there is 1 item with SKU 5 with quantity 4
    And there is 1 item with SKU 5 with quantity 3

  Scenario: There is an item with a duplicate SKU but a different description
    Given a cart with 1 item with SKU 5 with description "red" with quantity 3
    And a cart with 1 item with SKU 5 with description "blue" with quantity 3
    When I set the quantity to 4 on 1 item with SKU 5 with description "blue"
    Then there is 1 item with SKU 5 with description "red" with quantity 3
    And there is 1 item with SKU 5 with description "blue" with quantity 4

  # Cucumber is not the right tool for this test
  Scenario: A quantity change takes less than 1 second at least 95% of the time

  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely

  Scenario: I set a quantity to a negative number
    Given a cart with 1 item with SKU 5 with quantity 3
    When I set the quantity to -4
    Then the quantity is 3

  Scenario: I set a quantity to a non-integer number
    Given a cart with 1 item with SKU 5 with quantity 3
    When I set the quantity to 4.5
    Then the quantity is 3

  Scenario: I set a quantity to a non-numeric value
    Given a cart with 1 item with SKU 5 with quantity 3
    When I set the quantity to abc
    Then the quantity is 3
