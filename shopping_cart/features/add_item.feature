Feature: Add to cart
  In order to buy things
  As a customer
  I want to add items to the shopping cart

  Scenario: I add my first item
    Given an empty cart
    When I add 1 item
    Then there is 1 item

  Scenario: I add a new item to an existing cart
    Given a cart with 1 item with SKU 5
    When I add 1 item with SKU 9
    Then there is 1 item with SKU 5
    And there is 1 item with SKU 9

  Scenario: I add a duplicate item
    Given a cart with 1 item with SKU 5 with description "engraved Jack"
    When I add 1 item with SKU 5 with description "engraved Jack"
    Then there are 2 items with SKU 5 "engraved Jack"

  Scenario: I add an item with a duplicate SKU but a different description
    Given a cart with 1 item with SKU 5 with description "engraved Jack"
    When I add 1 item with SKU 5 with description "engraved Jill"
    Then there is 1 item with SKU 5 "engraved Jack"
    Then there is 1 item with SKU 5 "engraved Jill"

  Scenario: I add more than one of an item
    Given an empty cart
    When I add 1 item with quantity 3
    Then there is 1 item with quantity 3

  # Cucumber is not the right tool for this test
  Scenario: Adding an item takes less than 1 second at least 95% of the time

  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely

  Scenario: I add 0 of an item that is already in the cart
    Given a cart with 1 item with SKU 5 with quantity 3
    When I add 1 item with SKU 5 with quantity 0
    Then there is 1 item with SKU 5 with quantity 3

  Scenario: I add 0 of an item that is not in the cart
    Given an empty cart
    When I add 1 item with SKU 5 with quantity 0
    Then there are 0 items with SKU 

  Scenario: I add an item that is out of stock
    Given an empty cart
    When I add 1 item with SKU out-of-stock
    Then I see "the out of stock order confirmation"

  Scenario: I accept that an out of stock item will be delayed
    Given an empty cart
    And "the out of stock order confirmation" for 1 item with SKU out-of-stock
    When I accept
    Then there is 1 item with SKU out-of-stock with label "backorder"

  Scenario: I decline to order an out of stock item
    Given an empty cart
    And the "out of stock order confirmation" for 1 item with SKU out-of-stock
    When I decline
    Then there are 0 items with SKU out-of-stock

  Scenario: I add an item that is discontinued
    Given an empty cart
    When I add 1 item with SKU discontinued
    Then I see "the discontinued message"
    And there are 0 items with SKU discontinued

  Scenario: I add an item that doesn't exist
    Given an empty cart
    When I add 1 item with SKU bogus
    Then there are 0 items with SKU bogus

  Scenario: I add a negative number of an item
    Given a cart with 1 item with SKU 5 with quantity 3
    When I add -2 items with SKU 5
    Then there is 1 item with SKU 5 with quantity 3

  Scenario: I add a non-integer number of an item
    Given a cart with 1 item with SKU 5 with quantity 3
    When I add 3.4 items with SKU 5
    Then there is 1 item with SKU 5 with quantity 3

  Scenario: I add a non-numeric value of an item
    Given a cart with 1 item with SKU 5 with quantity 3
    When I add abc items with SKU 5
    Then there is 1 item with SKU 5 with quantity 3
