Feature: Remove item to cart
  As a customer
  I need to able to remove items to cart

  Scenario Outline: Customer removes one item to the cart
    Given the cart has quantity of <quantity_1> of "item_1"
    When customer removes "item_1" of quantity <quantity_2>
    Then cart should have "item_1" of quantity <quantity_1> - <quantity_2>

    Examples:
      | quantity_1 | quantity_2 |
      |   10       |  3         |
      |    2       |  1         |
      |    1       |  1         |