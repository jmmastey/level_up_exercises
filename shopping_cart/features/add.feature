Feature: Add items to the cart
  As a shopper
  In order to purchase items from the e-commerce site
  I want to add items to the cart

  Background:
    Given Item A has 6 units in stock
      And Item B has 3 units in stock
      And Item C currently out-of-stock
      And Item D is a discontinued product

  @happy
  Scenario: Add items to an empty cart
    Given the cart is empty
    When I add 3 units of Item A to the cart
    Then I see 3 units of item A in the cart
      And I see 3 as total items in the cart

  @happy
  Scenario: Add items to an non-empty cart
    Given the cart has 3 units of Item A
    When I add 2 units of Item B to the cart
    Then I see 2 of Item B in the cart
      And I see 5 as total items in the cart

  @sad
  Scenario Outline: Add out-of stock items
    Given <cart_status>
    When I add 2 units of Item C
    Then I see out of stock error

    Examples:
    | cart_status                    |
    | the cart is empty              |
    | the cart has 3 units of Item A |

  @sad
  Scenario Outline: Add discontinued stock items
    Given <cart_status>
    When I add 1 unit of Item D
    Then I see discontinued product error

    Examples:
    | cart_status                    |
    | the cart is empty              |
    | the cart has 3 units of Item A |

  @sad
  Scenario: Add more than the availability
    Given the cart has 3 units of Item A
    When I add 4 units of Item A to the cart
    Then I see only 6 units of Item A in the cart

  @bad
  Scenario Outline: Add negative quantities
    Given <cart_status>
    When I add -1 units of Item A to the cart
    Then I see invalid quantity error

    Examples:
    | cart_status                    |
    | the cart is empty              |
    | the cart has 3 units of Item A |
