Feature: Add item to cart
  As a customer
  I need to able to add items to cart

  Scenario: Customer add item to the cart
    Given the cart is empty
    When "item_1" is added to cart
    Then customer should see "item_1" in the cart

  Scenario: Customer adds one item to the cart
    Given the cart has quantity of "1" of "item_1"
    When "item_1" is added to cart
    Then cart should have  quantity of "2" of "item_1"

  Scenario Outline: Customer adds one item to the cart
    Given the cart has quantity of <quantity_1> of "item_1"
    When customer adds "item_1" of quantity <quantity_2>
    Then cart should have "item_1" of quantity <quantity_1> + <quantity_2>

    Examples:
      | quantity_1 | quantity_2 |
      |   10       |  3         |
      |    2       |  1         |
