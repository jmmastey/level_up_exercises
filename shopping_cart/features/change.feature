Feature: Change quantities in the cart
  As a shopper
  In order to manage the cart
  I want to change quantity of the items from the carts

  Background:
    Given Item A has 6 units in stock
      And the cart has 3 units of Item A


  @happy
  Scenario: Increase the quantity of an item within the stock level
    When I increase the quantity of Item A to 5
    Then I see 5 units of Item A in the cart

  @happy
  Scenario Outline: decrease the quantity of an item
    When I decrease the quantity of Item A by <quantity>
    Then <result>

    Examples:
    | quantity | result                             |
    | 2        | I see 1 unit of Item A in the cart |
    | 3        | I see an empty cart                |

  @sad
  Scenario: Increase the quantity beyond the stock level.
    When I increase the quantity of Item A to 7
    Then I see 5 units of Item A in the cart

  @bad
  Scenario: change the quantity of item not in the cart
    When I somehow increase the quantity of Item B to 3
    Then I should see invalid request error
