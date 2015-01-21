Feature: Change item to cart
  As a customer
  I need to able to change items to cart

  Scenario: Customer adds additional items to the cart
    Given the cart has "item_1"
    When "item_2" is added to cart
    Then customer should see following in the cart:
    | item_1 |
    | item_2 |

  Scenario: Customer removes only some items to the cart
    Given the cart has @item1, @item2
    When customer remove @item2 from cart
    Then customer should see @item1 in the cart
    And  customer should not see @item_2 in the cart
