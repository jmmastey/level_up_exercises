Feature: Add items to the cart
  As a shopper
  In order to purchase items from the e-commerce site
  I want to add items to the cart

  Background:
    Given Item A has 6 units in stock
      And Item B has 3 units in stock
      And Item C has 0 units in stock
      And Item D is a discontinued product

  @happy
  Scenario: Add items to an empty cart
    When I add 3 units of Item A to the cart
    Then I see 3 units of Item A in the cart
      And the total quantity in the cart is 3

  @happy
  Scenario: Add items to an non-empty cart
    Given the cart has 3 units of Item A
    When I add 2 units of Item B to the cart
    Then I see 2 of Item B in the cart
      And the total quantity in the cart is 5

  @sad
  Scenario: Add out-of stock items
    When I add 2 units of Item C to the cart
    Then I see out of stock error

  @sad
  Scenario: Add discontinued stock items
    When I add 1 unit of Item D
    Then I see discontinued product error

  @sad
  Scenario: Add more than the availability
    Given the cart has 3 units of Item A
    When I add 4 units of Item A to the cart
    Then I see 6 units of Item A in the cart
      And Item A has 0 units in stock
      And I see exceeds availability error

  @bad
  Scenario: Add negative quantities
    When I add -1 units of Item A to the cart
    Then I see invalid quantity error
